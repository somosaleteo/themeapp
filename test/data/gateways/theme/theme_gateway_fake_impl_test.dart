import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';
import 'package:themeapp/data/gateways/theme/theme_gateway_fake_impl.dart';
import 'package:themeapp/domain/models/theme_model.dart';

void main() {
  late ThemeGatewayFakeImpl themeGateway;
  late ThemeModel themeModelDark;
  late ThemeModel themeModelLight;

  setUp(() {
    themeGateway = ThemeGatewayFakeImpl();
    themeModelDark = ThemeModel(
      color: Colors.black,
      createdAt: DateTime.now(),
      description: 'Testing',
    );
    themeModelLight = ThemeModel(
      color: Colors.purpleAccent,
      createdAt: DateTime.now(),
      description: 'Testing',
    );
  });

  group('ThemeGatewayFakeImpl', () {
    test('debe retornar el defaultThemeModel al inicio', () async {
      final Either<ErrorItem, Map<String, dynamic>?> result =
          await themeGateway.getCurrentThemeModel();
      expect(result.isRight, isTrue);
      result.fold((_) => fail('Debe ser Right'), (Map<String, dynamic>? map) {
        final ThemeModel model = ThemeModel.fromMap(map!);
        expect(
          model.color.toARGB32(),
          equals(defaultThemeModel.color.toARGB32()),
        );
        expect(model.createdAt, equals(defaultThemeModel.createdAt));
        expect(model.description, equals(defaultThemeModel.description));
      });
    });

    test('debe actualizar el tema con saveThemeModel', () async {
      final ThemeModel nuevoTema = themeModelDark;
      final Either<ErrorItem, void> saveResult = await themeGateway
          .saveThemeModel(nuevoTema.toJson());
      expect(saveResult.isRight, isTrue);
      final Either<ErrorItem, Map<String, dynamic>?> result =
          await themeGateway.getCurrentThemeModel();
      expect(result.isRight, isTrue);
      result.fold((_) => fail('Debe ser Right'), (Map<String, dynamic>? map) {
        final ThemeModel model = ThemeModel.fromMap(map!);
        expect(model.color.toARGB32(), equals(nuevoTema.color.toARGB32()));
        expect(model.createdAt, equals(nuevoTema.createdAt));
        expect(model.description, equals(nuevoTema.description));
      });
    });

    test('debe emitir cambios en el stream de temas', () async {
      final List<ThemeModel> temasEmitidos = <ThemeModel>[];
      final StreamSubscription<Either<ErrorItem, Map<String, dynamic>>>
      subscription = themeGateway.onThemeChanged().listen((
        Either<ErrorItem, Map<String, dynamic>> either,
      ) {
        either.fold(
          (_) => null,
          (Map<String, dynamic> map) =>
              temasEmitidos.add(ThemeModel.fromMap(map)),
        );
      });

      final ThemeModel tema1 = themeModelDark;
      final ThemeModel tema2 = themeModelLight;

      await themeGateway.saveThemeModel(tema1.toJson());
      await themeGateway.saveThemeModel(tema2.toJson());

      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(temasEmitidos.length, 3);
      expect(
        temasEmitidos[0].color.toARGB32(),
        equals(defaultThemeModel.color.toARGB32()),
      );
      expect(temasEmitidos[1].color.toARGB32(), equals(tema1.color.toARGB32()));
      expect(temasEmitidos[2].color.toARGB32(), equals(tema2.color.toARGB32()));
      await subscription.cancel();
    });
  });
}

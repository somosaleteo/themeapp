import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
      final ThemeModel result = await themeGateway.getCurrentThemeModel();
      expect(result, equals(defaultThemeModel));
    });

    test('debe actualizar el tema con saveThemeModel', () async {
      final ThemeModel nuevoTema =
          themeModelDark; // o construye uno a mano si no tienes un factory
      await themeGateway.saveThemeModel(nuevoTema);
      final ThemeModel result = await themeGateway.getCurrentThemeModel();
      expect(result, equals(nuevoTema));
    });

    test('debe emitir cambios en el stream de temas', () async {
      final List<ThemeModel> temasEmitidos = <ThemeModel>[];
      final StreamSubscription<ThemeModel> subscription = themeGateway
          .onThemeChanged()
          .listen(temasEmitidos.add);

      final ThemeModel tema1 = themeModelDark;
      final ThemeModel tema2 = themeModelLight;

      await themeGateway.saveThemeModel(tema1);
      await themeGateway.saveThemeModel(tema2);

      await Future<void>.delayed(
        const Duration(milliseconds: 10),
      ); // da tiempo a emitir

      expect(
        temasEmitidos,
        containsAllInOrder(<ThemeModel>[defaultThemeModel, tema1, tema2]),
      );

      await subscription.cancel();
    });
  });
}

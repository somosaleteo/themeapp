import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:themeapp/data/repositories/theme/theme_repository_impl.dart';
import 'package:themeapp/domain/gateways/theme_gateway.dart';
import 'package:themeapp/domain/models/theme_model.dart'; // Asegúrate de incluir ThemeModel, ThemeGateway, ThemeRepository

class MockThemeGateway extends Mock implements ThemeGateway {}

late MockThemeGateway mockGateway;
late ThemeRepositoryImpl repository;
final ThemeModel themeModel = ThemeModel(
  color: const Color(0xFFAA00FF),
  createdAt: DateTime(2025, 5, 8),
  description: 'Tema para prueba',
);

void main() {
  setUp(() {
    mockGateway = MockThemeGateway();
    repository = ThemeRepositoryImpl(gateway: mockGateway);
    // Mock por defecto para evitar null
    when(() => mockGateway.getCurrentThemeModel()).thenAnswer(
      (_) async => Right<ErrorItem, Map<String, dynamic>?>(themeModel.toJson()),
    );
  });

  group('ThemeRepositoryImpl', () {
    test('saveTheme debe delegar a gateway.saveThemeModel', () async {
      final Map<String, dynamic> map = themeModel.toJson();
      when(
        () => mockGateway.saveThemeModel(map),
      ).thenAnswer((_) async => Right<ErrorItem, void>(null));

      await repository.saveTheme(themeModel);

      verify(() => mockGateway.saveThemeModel(map)).called(1);
    });

    test('loadTheme debe delegar a gateway.getCurrentThemeModel', () async {
      final Either<ErrorItem, ThemeModel?> result =
          await repository.loadTheme();
      expect(result.isRight, isTrue);
      result.fold((_) => fail('Debe ser Right'), (ThemeModel? theme) {
        expect(theme, isNotNull);
        expect(theme!.color, equals(themeModel.color));
        expect(theme.createdAt, equals(themeModel.createdAt));
        expect(theme.description, equals(themeModel.description));
      });
      verify(() => mockGateway.getCurrentThemeModel()).called(1);
    });

    test('listenToRemoteTheme debe delegar a gateway.onThemeChanged', () async {
      final Map<String, dynamic> map = themeModel.toJson();
      final StreamController<Either<ErrorItem, Map<String, dynamic>>>
      controller = StreamController<Either<ErrorItem, Map<String, dynamic>>>();
      when(
        () => mockGateway.onThemeChanged(),
      ).thenAnswer((_) => controller.stream);

      final List<ThemeModel> emitted = <ThemeModel>[];
      final StreamSubscription<Either<ErrorItem, ThemeModel>> subscription =
          repository.listenToRemoteTheme().listen((
            Either<ErrorItem, ThemeModel> either,
          ) {
            emitted.clear(); // Limpiar antes de agregar
            either.fold((_) => null, (ThemeModel theme) => emitted.add(theme));
          });

      controller.add(Right<ErrorItem, Map<String, dynamic>>(map));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(emitted.length, 1);
      expect(emitted.first.color, equals(themeModel.color));
      expect(emitted.first.createdAt, equals(themeModel.createdAt));
      expect(emitted.first.description, equals(themeModel.description));

      await subscription.cancel();
      await controller.close();
    });
  });
}

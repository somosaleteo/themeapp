import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:themeapp/data/repositories/theme/theme_repository_impl.dart';
import 'package:themeapp/domain/gateways/theme_gateway.dart';
import 'package:themeapp/domain/models/theme_model.dart'; // Asegúrate de incluir ThemeModel, ThemeGateway, ThemeRepository

class MockThemeGateway extends Mock implements ThemeGateway {}

void main() {
  late MockThemeGateway mockGateway;
  late ThemeRepositoryImpl repository;

  setUp(() {
    mockGateway = MockThemeGateway();
    repository = ThemeRepositoryImpl(gateway: mockGateway);
  });

  group('ThemeRepositoryImpl', () {
    final ThemeModel themeModel = ThemeModel(
      color: const Color(0xFFAA00FF),
      createdAt: DateTime(2025, 5, 8),
      description: 'Tema para prueba',
    );

    test('saveTheme debe delegar a gateway.saveThemeModel', () async {
      when(
        () => mockGateway.saveThemeModel(themeModel),
      ).thenAnswer((_) async => <String, dynamic>{});

      await repository.saveTheme(themeModel);

      verify(() => mockGateway.saveThemeModel(themeModel)).called(1);
    });

    test('loadTheme debe delegar a gateway.getCurrentThemeModel', () async {
      when(
        () => mockGateway.getCurrentThemeModel(),
      ).thenAnswer((_) async => themeModel);

      final ThemeModel? result = await repository.loadTheme();

      expect(result, equals(themeModel));
      verify(() => mockGateway.getCurrentThemeModel()).called(1);
    });

    test('listenToRemoteTheme debe delegar a gateway.onThemeChanged', () async {
      final StreamController<ThemeModel> controller =
          StreamController<ThemeModel>();
      when(
        () => mockGateway.onThemeChanged(),
      ).thenAnswer((_) => controller.stream);

      final List<ThemeModel> emitted = <ThemeModel>[];
      final StreamSubscription<ThemeModel> subscription = repository
          .listenToRemoteTheme()
          .listen(emitted.add);

      controller.add(themeModel);
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(emitted.length, 1);
      expect(emitted.first.description, equals(themeModel.description));

      await subscription.cancel();
      await controller.close();
    });
  });
}

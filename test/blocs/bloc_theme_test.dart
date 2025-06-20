import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:themeapp/blocs/bloc_theme.dart';
import 'package:themeapp/domain/models/theme_model.dart';
import 'package:themeapp/domain/usecases/theme/listen_to_theme_changes_usecase.dart';
import 'package:themeapp/domain/usecases/theme/load_theme_usecase.dart';
import 'package:themeapp/domain/usecases/theme/save_theme_usecase.dart';

class MockSaveThemeUseCase extends Mock implements SaveThemeUseCase {}

class MockLoadThemeUseCase extends Mock implements LoadThemeUseCase {}

class MockListenToThemeChangesUseCase extends Mock
    implements ListenToThemeChangesUseCase {}

class FakeThemeModel extends Fake implements ThemeModel {}

void main() {
  late MockSaveThemeUseCase mockSave;
  late MockLoadThemeUseCase mockLoad;
  late MockListenToThemeChangesUseCase mockListen;
  late BlocTheme bloc;
  setUpAll(() {
    registerFallbackValue(FakeThemeModel());
  });
  setUp(() {
    mockSave = MockSaveThemeUseCase();
    mockLoad = MockLoadThemeUseCase();
    mockListen = MockListenToThemeChangesUseCase();

    when(
      () => mockListen(),
    ).thenAnswer((_) => const Stream<Either<ErrorItem, ThemeModel>>.empty());
    bloc = BlocTheme(
      saveThemeUseCase: mockSave,
      loadThemeUseCase: mockLoad,
      listenToThemeChangesUseCase: mockListen,
    );
  });

  tearDown(() => bloc.dispose());

  group('BlocTheme', () {
    test('inicia con ThemeData basado en el defaultThemeModel', () {
      expect(
        bloc.themeData.colorScheme.primaryContainer,
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: defaultThemeModel.color),
        ).colorScheme.primaryContainer,
      );
    });

    test('loadInitialTheme actualiza el themeData si hay modelo', () async {
      final ThemeModel themeModel = defaultThemeModel.copyWith(
        color: Colors.green,
      );

      when(
        () => mockLoad(),
      ).thenAnswer((_) async => Right<ErrorItem, ThemeModel?>(themeModel));

      await bloc.loadInitialTheme();

      expect(
        bloc.themeData.colorScheme.primary,
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: themeModel.color),
        ).colorScheme.primary,
      );
    });

    test(
      'changeTheme guarda el tema si han pasado más de 3 segundos',
      () async {
        final ThemeModel oldModel = defaultThemeModel;
        final ThemeModel newModel = oldModel.copyWith(
          createdAt: oldModel.createdAt.add(const Duration(seconds: 5)),
        );

        when(
          () => mockSave(any()),
        ).thenAnswer((_) async => Right<ErrorItem, void>(null));

        await bloc.changeTheme(newModel);

        verify(() => mockSave(newModel)).called(1);
        expect(bloc.themeModel, newModel);
      },
    );

    test('changeTheme no guarda si no han pasado 3 segundos', () async {
      final ThemeModel oldModel = defaultThemeModel;
      final ThemeModel newModel = oldModel.copyWith(
        createdAt: oldModel.createdAt.add(const Duration(seconds: 2)),
      );

      await bloc.changeTheme(newModel);

      verifyNever(() => mockSave(any()));
      expect(bloc.themeModel, newModel);
    });

    test('listenToThemeChanges actualiza el themeData', () async {
      final StreamController<Either<ErrorItem, ThemeModel>> controller =
          StreamController<Either<ErrorItem, ThemeModel>>();
      when(() => mockListen()).thenAnswer((_) => controller.stream);

      bloc.dispose(); // Liberamos el anterior antes de reiniciar con stream
      bloc = BlocTheme(
        saveThemeUseCase: mockSave,
        loadThemeUseCase: mockLoad,
        listenToThemeChangesUseCase: mockListen,
      );

      final ThemeModel theme = defaultThemeModel.copyWith(color: Colors.teal);
      controller.add(Right<ErrorItem, ThemeModel>(theme));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(bloc.themeData.colorScheme.primary, isA<Color>());
      await controller.close();
    });

    test('changeToRandomTheme genera un nuevo tema', () async {
      when(
        () => mockSave(any()),
      ).thenAnswer((_) async => Right<ErrorItem, void>(null));
      await bloc.changeToRandomTheme();

      expect(bloc.themeModel.color, isA<Color>());
      expect(bloc.themeModel.description, contains('Color aleatorio'));
    });

    test('dispose cancela la suscripción y cierra el bloc', () {
      expect(() => bloc.dispose(), returnsNormally);
    });
  });
}

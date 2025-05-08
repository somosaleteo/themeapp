import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../domain/models/theme_model.dart';
import '../domain/usecases/theme/listen_to_theme_changes_usecase.dart';
import '../domain/usecases/theme/load_theme_usecase.dart';
import '../domain/usecases/theme/save_theme_usecase.dart';

class BlocTheme extends BlocModule {
  BlocTheme({
    required this.saveThemeUseCase,
    required this.loadThemeUseCase,
    required this.listenToThemeChangesUseCase,
  }) {
    _listenToThemeChanges();
  }

  final SaveThemeUseCase saveThemeUseCase;
  final LoadThemeUseCase loadThemeUseCase;
  final ListenToThemeChangesUseCase listenToThemeChangesUseCase;

  final BlocGeneral<ThemeData> _blocTheme = BlocGeneral<ThemeData>(
    ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: defaultThemeModel.color),
    ),
  );

  final BlocGeneral<ThemeModel> _blocThemeModel = BlocGeneral<ThemeModel>(
    defaultThemeModel,
  );

  StreamSubscription<ThemeModel>? _subscription;

  Stream<ThemeData> get themeStream => _blocTheme.stream;
  Stream<ThemeModel> get themeModelStream => _blocThemeModel.stream;
  ThemeData get themeData => _blocTheme.value;
  ThemeModel get themeModel => _blocThemeModel.value;

  set themeData(ThemeData themeData) {
    _blocTheme.value = themeData;
  }

  Future<void> changeTheme(ThemeModel model) async {
    final ThemeModel previous = _blocThemeModel.value;

    _blocThemeModel.value = model;
    if (_shouldSaveTheme(previous, model)) {
      await saveThemeUseCase(model);
    }
  }

  bool _shouldSaveTheme(ThemeModel oldModel, ThemeModel newModel) {
    final int differenceInSeconds =
        newModel.createdAt.difference(oldModel.createdAt).inSeconds;
    return differenceInSeconds > 3;
  }

  Future<void> loadInitialTheme() async {
    final ThemeModel? model = await loadThemeUseCase();
    if (model != null) {
      themeData = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: model.color),
      );
    }
  }

  void _listenToThemeChanges() {
    _subscription = listenToThemeChangesUseCase().listen((ThemeModel model) {
      debugPrint('Escuchando el cambio del tema');
      themeData = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: model.color),
      );
    });
  }

  final List<Color> _availableColors = <Color>[
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.indigo,
    Colors.cyan,
    Colors.deepOrange,
    Colors.black,
    Colors.grey,
  ];

  void changeToRandomTheme() {
    final Random random = Random();
    final Color color =
        _availableColors[random.nextInt(_availableColors.length)];
    final ThemeModel model = ThemeModel(
      color: color,
      createdAt: DateTime.now(),
      description:
          'Color aleatorio: #${color.toARGB32().toRadixString(16).toUpperCase()}',
    );

    changeTheme(model);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _blocTheme.dispose();
  }
}

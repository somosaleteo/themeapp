import 'package:flutter/material.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../domain/models/theme_model.dart';

class BlocTheme extends BlocModule {
  final BlocGeneral<ThemeData> _blocTheme = BlocGeneral<ThemeData>(
    ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: defaultThemeModel.color),
    ),
  );

  Stream<ThemeData> get themeStream => _blocTheme.stream;
  ThemeData get themeData => _blocTheme.value;

  set themeData(ThemeData themeData) {
    _blocTheme.value = themeData;
  }

  @override
  void dispose() {
    _blocTheme.dispose();
  }
}

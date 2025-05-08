import 'dart:async';

import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../../domain/gateways/theme_gateway.dart';
import '../../../domain/models/theme_model.dart';

class ThemeGatewayFakeImpl implements ThemeGateway {
  final BlocGeneral<ThemeModel> _themeBloc = BlocGeneral<ThemeModel>(
    defaultThemeModel,
  );

  @override
  Future<ThemeModel> getCurrentThemeModel() async {
    return _themeBloc.value;
  }

  @override
  Future<void> saveThemeModel(ThemeModel themeModel) async {
    _themeBloc.value = themeModel;
  }

  @override
  Stream<ThemeModel> onThemeChanged() {
    return _themeBloc.stream;
  }
}

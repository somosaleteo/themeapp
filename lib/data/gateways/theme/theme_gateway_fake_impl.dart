import 'dart:async';

import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../../domain/gateways/theme_gateway.dart';
import '../../../domain/models/theme_model.dart';

class ThemeGatewayFakeImpl implements ThemeGateway {
  final BlocGeneral<Either<ErrorItem, Map<String, dynamic>>> _themeBloc =
      BlocGeneral<Either<ErrorItem, Map<String, dynamic>>>(
        Right<ErrorItem, Map<String, dynamic>>(defaultThemeModel.toJson()),
      );

  @override
  Future<Either<ErrorItem, Map<String, dynamic>?>>
  getCurrentThemeModel() async {
    return _themeBloc.value;
  }

  @override
  Future<Either<ErrorItem, void>> saveThemeModel(
    Map<String, dynamic> json,
  ) async {
    _themeBloc.value = Right<ErrorItem, Map<String, dynamic>>(json);
    return Right<ErrorItem, void>(null);
  }

  @override
  Stream<Either<ErrorItem, Map<String, dynamic>>> onThemeChanged() {
    return _themeBloc.stream;
  }
}

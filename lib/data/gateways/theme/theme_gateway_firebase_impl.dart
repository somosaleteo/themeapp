import 'dart:async';

import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../../domain/entities/services/service_firebase_database.dart';
import '../../../domain/gateways/theme_gateway.dart';

class ThemeGatewayFirebaseImpl implements ThemeGateway {
  ThemeGatewayFirebaseImpl(this.service);
  final ServiceFirebaseDatabase service;
  final String _path = 'theme_model/current';

  @override
  Future<Either<ErrorItem, void>> saveThemeModel(Map<String, dynamic> json) {
    return service.write(_path, json);
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>?>>
  getCurrentThemeModel() async {
    return service.read(_path);
  }

  @override
  Stream<Either<ErrorItem, Map<String, dynamic>>> onThemeChanged() {
    return service.onValue(_path);
  }
}

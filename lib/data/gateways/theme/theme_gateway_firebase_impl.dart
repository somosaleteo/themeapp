import 'dart:async';

import '../../../domain/entities/services/service_firebase_database.dart';
import '../../../domain/gateways/theme_gateway.dart';
import '../../../domain/models/theme_model.dart';

class ThemeGatewayFirebaseImpl implements ThemeGateway {
  ThemeGatewayFirebaseImpl(this.service);
  final ServiceFirebaseDatabase service;
  final String _path = 'theme_model/current';

  @override
  Future<void> saveThemeModel(ThemeModel themeModel) {
    return service.write(_path, themeModel.toJson());
  }

  @override
  Future<ThemeModel?> getCurrentThemeModel() async {
    final Map<String, dynamic>? data = await service.read(_path);
    return data != null ? ThemeModel.fromMap(data) : null;
  }

  @override
  Stream<ThemeModel> onThemeChanged() {
    return service.onValue(_path).map(ThemeModel.fromMap);
  }
}

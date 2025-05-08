import '../entities/gateway.dart';
import '../models/theme_model.dart';

abstract class ThemeGateway extends Gateway {
  Future<void> saveThemeModel(ThemeModel themeModel);
  Future<ThemeModel?> getCurrentThemeModel();
  Stream<ThemeModel> onThemeChanged();
}

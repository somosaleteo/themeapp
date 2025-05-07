import '../../domain/entities/gateway.dart';
import '../../domain/models/theme_model.dart';

abstract class ThemeGateway extends Gateway {
  Future<void> saveThemeModel(ThemeModel themeModel);
  Future<ThemeModel?> getCurrentThemeModel();
  Stream<ThemeModel> onThemeChanged();
}

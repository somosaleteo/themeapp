import '../../../domain/gateways/theme_gateway.dart';
import '../../../domain/models/theme_model.dart';
import '../../../domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.gateway});

  final ThemeGateway gateway;

  @override
  Future<void> saveTheme(ThemeModel themeModel) {
    return gateway.saveThemeModel(themeModel);
  }

  @override
  Future<ThemeModel?> loadTheme() {
    return gateway.getCurrentThemeModel();
  }

  @override
  Stream<ThemeModel> listenToRemoteTheme() {
    return gateway.onThemeChanged();
  }
}

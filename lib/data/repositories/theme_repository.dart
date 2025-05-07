import '../../domain/entities/repository.dart';
import '../../domain/models/theme_model.dart';

abstract class ThemeRepository extends Repository {
  Future<void> saveTheme(ThemeModel themeModel);
  Future<ThemeModel?> loadTheme();
  Stream<ThemeModel> listenToRemoteTheme();
}

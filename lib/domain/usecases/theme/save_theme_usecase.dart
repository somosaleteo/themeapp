import '../../entities/usecase.dart';
import '../../models/theme_model.dart';
import '../../repositories/theme_repository.dart';

class SaveThemeUseCase extends UseCase {
  const SaveThemeUseCase(this.repository);
  final ThemeRepository repository;

  Future<void> call(ThemeModel theme) {
    return repository.saveTheme(theme);
  }
}

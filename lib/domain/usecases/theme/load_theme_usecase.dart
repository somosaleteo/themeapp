import '../../entities/usecase.dart';
import '../../models/theme_model.dart';
import '../../repositories/theme_repository.dart';

class LoadThemeUseCase extends UseCase {
  const LoadThemeUseCase(this.repository);
  final ThemeRepository repository;

  Future<ThemeModel?> call() {
    return repository.loadTheme();
  }
}

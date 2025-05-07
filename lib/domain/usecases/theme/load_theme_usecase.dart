import '../../../data/repositories/theme_repository.dart';
import '../../entities/usecase.dart';
import '../../models/theme_model.dart';

class LoadThemeUseCase extends UseCase {
  const LoadThemeUseCase(this.repository);
  final ThemeRepository repository;

  Future<ThemeModel?> call() {
    return repository.loadTheme();
  }
}

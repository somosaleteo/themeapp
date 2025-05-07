import '../../../data/repositories/theme_repository.dart';
import '../../entities/usecase.dart';
import '../../models/theme_model.dart';

class ListenToThemeChangesUseCase extends UseCase {
  const ListenToThemeChangesUseCase(this.repository);
  final ThemeRepository repository;

  Stream<ThemeModel> call() {
    return repository.listenToRemoteTheme();
  }
}

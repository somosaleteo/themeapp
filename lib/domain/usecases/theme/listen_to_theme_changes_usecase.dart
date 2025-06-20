import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../entities/usecase.dart';
import '../../models/theme_model.dart';
import '../../repositories/theme_repository.dart';

class ListenToThemeChangesUseCase extends UseCase {
  const ListenToThemeChangesUseCase(this.repository);
  final ThemeRepository repository;

  Stream<Either<ErrorItem, ThemeModel>> call() {
    return repository.listenToRemoteTheme();
  }
}

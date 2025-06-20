import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../entities/usecase.dart';
import '../../models/theme_model.dart';
import '../../repositories/theme_repository.dart';

class SaveThemeUseCase extends UseCase {
  const SaveThemeUseCase(this.repository);
  final ThemeRepository repository;

  Future<Either<ErrorItem, void>> call(ThemeModel theme) {
    return repository.saveTheme(theme);
  }
}

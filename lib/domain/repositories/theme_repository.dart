import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../entities/repository.dart';
import '../models/theme_model.dart';

abstract class ThemeRepository extends Repository {
  Future<Either<ErrorItem, void>> saveTheme(ThemeModel themeModel);
  Future<Either<ErrorItem, ThemeModel?>> loadTheme();
  Stream<Either<ErrorItem, ThemeModel>> listenToRemoteTheme();
}

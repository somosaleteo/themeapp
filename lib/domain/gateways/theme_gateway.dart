import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../entities/gateway.dart';

abstract class ThemeGateway extends Gateway {
  Future<Either<ErrorItem, void>> saveThemeModel(Map<String, dynamic> json);
  Future<Either<ErrorItem, Map<String, dynamic>?>> getCurrentThemeModel();
  Stream<Either<ErrorItem, Map<String, dynamic>>> onThemeChanged();
}

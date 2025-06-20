import 'dart:async';

import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../../domain/gateways/theme_gateway.dart';
import '../../../domain/models/theme_model.dart';
import '../../../domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.gateway});

  final ThemeGateway gateway;

  StreamSubscription? _streamSubscription;

  final BlocGeneral<Either<ErrorItem, ThemeModel>> _bloc =
      BlocGeneral<Either<ErrorItem, ThemeModel>>(
        Right<ErrorItem, ThemeModel>(defaultThemeModel),
      );

  @override
  Future<Either<ErrorItem, void>> saveTheme(ThemeModel themeModel) {
    return gateway.saveThemeModel(themeModel.toJson());
  }

  @override
  Future<Either<ErrorItem, ThemeModel?>> loadTheme() async {
    final Either<ErrorItem, Map<String, dynamic>?> result =
        await gateway.getCurrentThemeModel();

    return result.fold(
      (ErrorItem l) => Left<ErrorItem, ThemeModel?>(l),
      (Map<String, dynamic>? r) => Right<ErrorItem, ThemeModel?>(
        r == null ? null : ThemeModel.fromMap(r),
      ),
    );
  }

  @override
  Stream<Either<ErrorItem, ThemeModel>> listenToRemoteTheme() {
    final Stream<Either<ErrorItem, Map<String, dynamic>>> result =
        gateway.onThemeChanged();
    _streamSubscription?.cancel();
    _streamSubscription = result.listen((
      Either<ErrorItem, Map<String, dynamic>> event,
    ) {
      event.fold(
        (ErrorItem l) => _bloc.value = Left<ErrorItem, ThemeModel>(l),
        (Map<String, dynamic> r) =>
            _bloc.value = Right<ErrorItem, ThemeModel>(ThemeModel.fromMap(r)),
      );
    });
    return _bloc.stream;
  }

  void dispose() {
    _streamSubscription?.cancel();
    _bloc.dispose();
  }
}

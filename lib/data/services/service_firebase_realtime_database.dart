import 'package:firebase_database/firebase_database.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../domain/entities/services/service_firebase_database.dart';

class ServiceFirebaseRealtimeDatabase implements ServiceFirebaseDatabase {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  @override
  Future<Either<ErrorItem, void>> write(
    String path,
    Map<String, dynamic> data,
  ) async {
    await _db.ref(path).set(data);
    return Right<ErrorItem, void>(null);
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>?>> read(String path) async {
    final DataSnapshot snapshot = await _db.ref(path).get();
    if (snapshot.exists && snapshot.value is Map<String, dynamic>) {
      return Right<ErrorItem, Map<String, dynamic>?>(
        Utils.mapFromDynamic(snapshot.value),
      );
    }
    return Left<ErrorItem, Map<String, dynamic>?>(
      const ErrorItem(
        title: 'No se ha podido leer el documento',
        code: '808',
        description:
            'Al comunicarse con Firebase no se ha podido leer el documento',
      ),
    );
  }

  @override
  Stream<Either<ErrorItem, Map<String, dynamic>>> onValue(String path) {
    return _db
        .ref(path)
        .onValue
        .where((DatabaseEvent event) => event.snapshot.value != null)
        .map(
          (DatabaseEvent event) => Right<ErrorItem, Map<String, dynamic>>(
            Utils.mapFromDynamic(event.snapshot.value),
          ),
        );
  }
}

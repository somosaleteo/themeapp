import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../domain/entities/services/service_firebase_database.dart';

class ServiceFirebaseFirestoreDatabase implements ServiceFirebaseDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Either<ErrorItem, void>> write(
    String path,
    Map<String, dynamic> data,
  ) async {
    await _db.doc(path).set(data);
    return Right<ErrorItem, void>(null);
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>?>> read(String path) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.doc(path).get();
    if (snapshot.exists) {
      return Right<ErrorItem, Map<String, dynamic>?>(
        Utils.mapFromDynamic(snapshot.data()),
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
        .doc(path)
        .snapshots()
        .where((DocumentSnapshot<Map<String, dynamic>> s) => s.exists)
        .map((DocumentSnapshot<Map<String, dynamic>> s) {
          return Right<ErrorItem, Map<String, dynamic>>(
            Utils.mapFromDynamic(s.data()),
          );
        });
  }
}

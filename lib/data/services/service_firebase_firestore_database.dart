import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../domain/entities/services/service_firebase_database.dart';

class ServiceFirebaseFirestoreDatabase implements ServiceFirebaseDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> write(String path, Map<String, dynamic> data) async {
    await _db.doc(path).set(data);
  }

  @override
  Future<Map<String, dynamic>?> read(String path) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.doc(path).get();
    if (snapshot.exists) {
      return Utils.mapFromDynamic(snapshot.data());
    }
    return null;
  }

  @override
  Stream<Map<String, dynamic>> onValue(String path) {
    return _db
        .doc(path)
        .snapshots()
        .where((DocumentSnapshot<Map<String, dynamic>> s) => s.exists)
        .map((DocumentSnapshot<Map<String, dynamic>> s) {
          return Utils.mapFromDynamic(s.data());
        });
  }
}

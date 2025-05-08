import 'package:firebase_database/firebase_database.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';

import '../../domain/entities/services/service_firebase_database.dart';

class ServiceFirebaseRealtimeDatabase implements ServiceFirebaseDatabase {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  @override
  Future<void> write(String path, Map<String, dynamic> data) async {
    await _db.ref(path).set(data);
  }

  @override
  Future<Map<String, dynamic>?> read(String path) async {
    final DataSnapshot snapshot = await _db.ref(path).get();
    if (snapshot.exists && snapshot.value is Map<String, dynamic>) {
      return Utils.mapFromDynamic(snapshot.value);
    }
    return null;
  }

  @override
  Stream<Map<String, dynamic>> onValue(String path) {
    return _db
        .ref(path)
        .onValue
        .where((DatabaseEvent event) => event.snapshot.value != null)
        .map(
          (DatabaseEvent event) => Utils.mapFromDynamic(event.snapshot.value),
        );
  }
}

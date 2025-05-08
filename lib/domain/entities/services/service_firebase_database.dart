abstract class ServiceFirebaseDatabase {
  Future<void> write(String path, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> read(String path);
  Stream<Map<String, dynamic>> onValue(String path);
}

// En un futuro podriamos cambiar a Firestore o RealDatabase con solo crear:
// ServiceFirebaseFirestoreDatabase implements ServiceFirebaseDatabase
// O usar un ServiceFirebaseDatabaseMock para tests.

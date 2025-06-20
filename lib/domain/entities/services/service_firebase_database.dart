import 'package:jocaagura_domain/jocaagura_domain.dart';

abstract class ServiceFirebaseDatabase {
  const ServiceFirebaseDatabase();
  Future<Either<ErrorItem, void>> write(String path, Map<String, dynamic> data);
  Future<Either<ErrorItem, Map<String, dynamic>?>> read(String path);
  Stream<Either<ErrorItem, Map<String, dynamic>>> onValue(String path);
}

// En un futuro podriamos cambiar a Firestore o RealDatabase con solo crear:
// ServiceFirebaseFirestoreDatabase implements ServiceFirebaseDatabase
// O usar un ServiceFirebaseDatabaseMock para tests.

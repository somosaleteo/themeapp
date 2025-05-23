abstract class ServiceDatabase {
  const ServiceDatabase();
  Future<void> write(String path, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> read(String path);
  Stream<Map<String, dynamic>> onValue(String path);
}

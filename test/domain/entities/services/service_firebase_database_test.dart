import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:themeapp/domain/entities/services/service_firebase_database.dart'; // Ajusta esta ruta si es necesario

class FakeServiceFirebaseDatabase extends ServiceFirebaseDatabase {
  const FakeServiceFirebaseDatabase();

  @override
  Future<void> write(String path, Map<String, dynamic> data) async {}

  @override
  Future<Map<String, dynamic>?> read(String path) async => <String, dynamic>{};

  @override
  Stream<Map<String, dynamic>> onValue(String path) =>
      const Stream<Map<String, dynamic>>.empty(); // o Stream.value({})
}

void main() {
  test('FakeServiceFirebaseDatabase puede ser instanciado como const', () {
    const FakeServiceFirebaseDatabase service = FakeServiceFirebaseDatabase();

    expect(service, isA<ServiceFirebaseDatabase>());
  });
}

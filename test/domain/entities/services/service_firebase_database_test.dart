import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';
import 'package:themeapp/domain/entities/services/service_firebase_database.dart';

class FakeServiceFirebaseDatabase extends ServiceFirebaseDatabase {
  const FakeServiceFirebaseDatabase();

  @override
  Future<Either<ErrorItem, void>> write(
    String path,
    Map<String, dynamic> data,
  ) async {
    return Right<ErrorItem, void>(null);
  }

  @override
  Future<Either<ErrorItem, Map<String, dynamic>?>> read(String path) async {
    return Right<ErrorItem, Map<String, dynamic>>(const <String, dynamic>{});
  }

  @override
  Stream<Either<ErrorItem, Map<String, dynamic>>> onValue(String path) {
    return Stream<Either<ErrorItem, Map<String, dynamic>>>.value(
      Right<ErrorItem, Map<String, dynamic>>(const <String, dynamic>{}),
    );
  }
}

void main() {
  test('FakeServiceFirebaseDatabase puede ser instanciado como const', () {
    const FakeServiceFirebaseDatabase service = FakeServiceFirebaseDatabase();

    expect(service, isA<ServiceFirebaseDatabase>());
  });
}

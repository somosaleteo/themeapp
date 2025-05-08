import 'package:flutter_test/flutter_test.dart';
import 'package:themeapp/domain/entities/gateway.dart';

class FakeGateway extends Gateway {
  const FakeGateway();
}

void main() {
  test('Gateway puede ser instanciado como const', () {
    const FakeGateway gateway = FakeGateway();

    expect(gateway, isA<Gateway>());
  });
}

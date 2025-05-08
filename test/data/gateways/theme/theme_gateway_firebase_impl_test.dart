import 'dart:async';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:themeapp/data/gateways/theme/theme_gateway_firebase_impl.dart';
import 'package:themeapp/domain/entities/services/service_firebase_database.dart';
import 'package:themeapp/domain/models/theme_model.dart'; // Ajusta si ThemeModel está en otro paquete

class MockServiceFirebaseDatabase extends Mock
    implements ServiceFirebaseDatabase {}

void main() {
  late MockServiceFirebaseDatabase mockService;
  late ThemeGatewayFirebaseImpl gateway;
  const String path = 'theme_model/current';

  setUp(() {
    mockService = MockServiceFirebaseDatabase();
    gateway = ThemeGatewayFirebaseImpl(mockService);
  });

  group('ThemeGatewayFirebaseImpl', () {
    final ThemeModel themeModel = ThemeModel(
      color: const Color(0xFFAA00FF),
      createdAt: DateTime(2025),
      description: 'Prueba Firebase',
    );

    test(
      'saveThemeModel llama a service.write con los argumentos correctos',
      () async {
        when(
          () => mockService.write(path, any()),
        ).thenAnswer((_) async => <String, dynamic>{});

        await gateway.saveThemeModel(themeModel);

        verify(() => mockService.write(path, themeModel.toJson())).called(1);
      },
    );

    test('getCurrentThemeModel retorna null si no hay datos', () async {
      when(() => mockService.read(path)).thenAnswer((_) async => null);

      final ThemeModel? result = await gateway.getCurrentThemeModel();

      expect(result, isNull);
    });

    test('getCurrentThemeModel retorna un ThemeModel si hay datos', () async {
      final Map<String, dynamic> json = themeModel.toJson();

      when(() => mockService.read(path)).thenAnswer((_) async => json);

      final ThemeModel? result = await gateway.getCurrentThemeModel();

      expect(result, isA<ThemeModel>());
      expect(result!.description, equals(themeModel.description));
      expect(result.color, equals(themeModel.color));
      expect(result.createdAt, equals(themeModel.createdAt));
    });

    test(
      'onThemeChanged transforma los datos del stream en ThemeModel',
      () async {
        final StreamController<Map<String, dynamic>> controller =
            StreamController<Map<String, dynamic>>();
        when(
          () => mockService.onValue(path),
        ).thenAnswer((_) => controller.stream);

        final List<ThemeModel> emitted = <ThemeModel>[];
        final StreamSubscription<ThemeModel> subscription = gateway
            .onThemeChanged()
            .listen(emitted.add);

        controller.add(themeModel.toJson());
        await Future<void>.delayed(const Duration(milliseconds: 10));

        expect(emitted.length, 1);
        expect(emitted.first.description, themeModel.description);

        await subscription.cancel();
        await controller.close();
      },
    );
  });
}

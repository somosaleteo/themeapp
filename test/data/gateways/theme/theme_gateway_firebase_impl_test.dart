import 'dart:async';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:jocaagura_domain/jocaagura_domain.dart';
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
        ).thenAnswer((_) async => Right<ErrorItem, void>(null));

        final Either<ErrorItem, void> result = await gateway.saveThemeModel(
          themeModel.toJson(),
        );
        expect(result.isRight, isTrue);
        verify(() => mockService.write(path, themeModel.toJson())).called(1);
      },
    );

    test('getCurrentThemeModel retorna null si no hay datos', () async {
      when(
        () => mockService.read(path),
      ).thenAnswer((_) async => Right<ErrorItem, Map<String, dynamic>?>(null));

      final Either<ErrorItem, Map<String, dynamic>?> result =
          await gateway.getCurrentThemeModel();
      expect(result.isRight, isTrue);
      result.fold(
        (_) => fail('Debe ser Right'),
        (Map<String, dynamic>? map) => expect(map, isNull),
      );
    });

    test('getCurrentThemeModel retorna un ThemeModel si hay datos', () async {
      final Map<String, dynamic> json = themeModel.toJson();

      when(
        () => mockService.read(path),
      ).thenAnswer((_) async => Right<ErrorItem, Map<String, dynamic>?>(json));

      final Either<ErrorItem, Map<String, dynamic>?> result =
          await gateway.getCurrentThemeModel();
      expect(result.isRight, isTrue);
      result.fold((_) => fail('Debe ser Right'), (Map<String, dynamic>? map) {
        final ThemeModel model = ThemeModel.fromMap(map!);
        expect(model.description, equals(themeModel.description));
        expect(model.color, equals(themeModel.color));
        expect(model.createdAt, equals(themeModel.createdAt));
      });
    });

    test(
      'onThemeChanged transforma los datos del stream en ThemeModel',
      () async {
        final StreamController<Either<ErrorItem, Map<String, dynamic>>>
        controller =
            StreamController<Either<ErrorItem, Map<String, dynamic>>>();
        when(
          () => mockService.onValue(path),
        ).thenAnswer((_) => controller.stream);

        final List<ThemeModel> emitted = <ThemeModel>[];
        final StreamSubscription<Either<ErrorItem, Map<String, dynamic>>>
        subscription = gateway.onThemeChanged().listen((
          Either<ErrorItem, Map<String, dynamic>> either,
        ) {
          either.fold(
            (_) => null,
            (Map<String, dynamic> map) => emitted.add(ThemeModel.fromMap(map)),
          );
        });

        controller.add(
          Right<ErrorItem, Map<String, dynamic>>(themeModel.toJson()),
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));

        expect(emitted.length, 1);
        expect(emitted.first.description, themeModel.description);
        expect(emitted.first.color.toARGB32(), themeModel.color.toARGB32());
        expect(emitted.first.createdAt, themeModel.createdAt);
        await subscription.cancel();
        await controller.close();
      },
    );
  });
}

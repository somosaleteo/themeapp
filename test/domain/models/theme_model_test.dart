import 'package:flutter/material.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:themeapp/domain/models/theme_model.dart'; // Asegúrate que aquí esté el ThemeModel y sus dependencias

void main() {
  group('ThemeModel', () {
    test('debe crear una instancia correctamente', () {
      final ThemeModel theme = ThemeModel(
        color: const Color(0xFFAA00FF),
        createdAt: DateTime(2025, 5, 8),
        description: 'Tema personalizado',
      );

      expect(theme.color, equals(const Color(0xFFAA00FF)));
      expect(theme.createdAt, equals(DateTime(2025, 5, 8)));
      expect(theme.description, equals('Tema personalizado'));
    });

    test('debe serializar a JSON correctamente', () {
      final ThemeModel theme = ThemeModel(
        color: const Color(0xFFAA00FF),
        createdAt: DateTime(2025, 5, 8, 10, 30),
        description: 'Morado',
      );

      final Map<String, dynamic> json = theme.toJson();
      expect(json['color'], equals('#FFAA00FF'));
      expect(json['createdAt'], equals('2025-05-08T10:30:00.000'));
      expect(json['description'], equals('Morado'));
    });

    test('debe deserializar desde JSON correctamente', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'color': '#FFAA00FF',
        'createdAt': '2025-05-08T10:30:00.000',
        'description': 'Morado',
      };

      final ThemeModel theme = ThemeModel.fromMap(json);

      expect(theme.color, equals(const Color(0xFFAA00FF)));
      expect(theme.createdAt, equals(DateTime(2025, 5, 8, 10, 30)));
      expect(theme.description, equals('Morado'));
    });

    test('copyWith debe actualizar solo las propiedades deseadas', () {
      final ThemeModel original = ThemeModel(
        color: const Color(0xFF000000),
        createdAt: DateTime(2025),
        description: 'Original',
      );
      final ThemeModel updatedOnly = original.copyWith();
      expect(updatedOnly.description, equals('Original'));
      final ThemeModel updated = original.copyWith(description: 'Actualizado');

      expect(updated.description, equals('Actualizado'));
      expect(updated.color, equals(original.color));
      expect(updated.createdAt, equals(original.createdAt));
    });

    test('toJson y fromMap deben ser simétricos', () {
      final ThemeModel theme = ThemeModel(
        color: const Color(0xFF123456),
        createdAt: DateTime(2025, 12, 24, 22, 45),
        description: 'Noche buena',
      );

      final Map<String, dynamic> json = theme.toJson();
      final ThemeModel restored = ThemeModel.fromMap(json);

      expect(restored.color, equals(theme.color));
      expect(restored.createdAt, equals(theme.createdAt));
      expect(restored.description, equals(theme.description));
    });
  });
}

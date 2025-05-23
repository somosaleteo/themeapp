import 'package:flutter/material.dart' as material;
import 'package:jocaagura_domain/jocaagura_domain.dart';

final ThemeModel defaultThemeModel = ThemeModel(
  color: material.Colors.purple,
  createdAt: DateTime(2025),
  description: 'Default color',
);

class ThemeModel extends Model {
  const ThemeModel({
    required this.color,
    required this.createdAt,
    required this.description,
    this.isDarkMode = false,
  });
  factory ThemeModel.fromMap(Map<String, dynamic> json) {
    final String hexColor = json['color'] as String;
    final int hexValue = int.parse(hexColor.replaceFirst('#', ''), radix: 16);

    return ThemeModel(
      color: material.Color(hexValue),
      createdAt: DateUtils.dateTimeFromDynamic(json['createdAt']),
      description: Utils.getStringFromDynamic(json['description']),
      isDarkMode: json['isDarkMode'] as bool? ?? false,
    );
  }
  final material.Color color;
  final DateTime createdAt;
  final String description;
  final bool isDarkMode;

  @override
  ThemeModel copyWith({
    material.Color? color,
    DateTime? createdAt,
    String? description,
    bool? isDarkMode,
  }) {
    return ThemeModel(
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'color':
          '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'isDarkMode': isDarkMode,
    };
  }
}

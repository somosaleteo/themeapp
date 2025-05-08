import 'package:flutter/material.dart';
import 'package:text_responsive/text_responsive.dart';

import '../../domain/models/theme_model.dart';

class ThemeModelCardWidget extends StatelessWidget {
  const ThemeModelCardWidget({required this.themeModel, super.key});

  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Imagen con overlay del primaryContainer
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.75),
              backgroundBlendMode: BlendMode.overlay,
            ),
          ),
          const SizedBox(height: 20.0),
          // Detalles del modelo
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 320.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: themeModel.color,
                      ),
                      const SizedBox(width: 8.0),
                      InlineTextWidget(
                        'Color: #${themeModel.color.toARGB32().toRadixString(16).toUpperCase()}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                InlineTextWidget(
                  'Descripción: ${themeModel.description}',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                InlineTextWidget(
                  'Creado: ${themeModel.createdAt.toLocal().toIso8601String()}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

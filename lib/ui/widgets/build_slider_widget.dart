import 'package:flutter/material.dart';

/// Un widget reutilizable que representa un control deslizante (slider)
/// con etiqueta, color personalizado y valor escalado visualmente.
///
/// Este widget se compone de:
/// - Un texto a la izquierda que representa la etiqueta (`label`).
/// - Un `Slider` central con color personalizado (`activeColor`).
/// - Un valor numérico a la derecha que representa el valor actual
///   multiplicado por 255 y redondeado hacia arriba.
///
/// Es útil para construir interfaces donde se requieren ajustes
/// granulares, como personalización de color RGB u otros controles
/// visuales.
///
/// ### Ejemplo de uso:
///
/// ```dart
/// BuildSliderWidget(
///   label: 'R',
///   value: 0.5,
///   color: Colors.red,
///   onChanged: (val) => print(val),
/// )
/// ```
class BuildSliderWidget extends StatelessWidget {
  /// Crea una instancia de [BuildSliderWidget].
  ///
  /// Los parámetros [label], [value], [color] y [onChanged] son requeridos.
  const BuildSliderWidget({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
    super.key,
  });

  /// La etiqueta del slider, típicamente un carácter como 'R', 'G', o 'B'.
  final String label;

  /// Valor actual del slider (esperado entre 0.0 y 1.0).
  final double value;

  /// Color del slider activo (por ejemplo: rojo, verde, azul).
  final Color color;

  /// Callback que se ejecuta cuando el valor del slider cambia.
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 20, child: Text(label)),
        Expanded(
          child: Slider(
            activeColor: color,
            value: value,
            divisions: 255,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 40, child: Text('${(value * 255).ceil()}')),
      ],
    );
  }
}

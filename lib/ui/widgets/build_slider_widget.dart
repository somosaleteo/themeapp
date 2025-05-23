import 'package:flutter/material.dart';

class BuildSliderWidget extends StatelessWidget {
  const BuildSliderWidget({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
    super.key,
  });
  final String label;
  final double value;
  final Color color;
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
        SizedBox(width: 40, child: Text(value.toInt().toString())),
      ],
    );
  }
}

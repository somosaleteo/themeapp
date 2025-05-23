import 'package:flutter/material.dart';

import '../../blocs/bloc_theme.dart';
import '../../domain/models/theme_model.dart';
import 'build_slider_widget.dart';

class ColorSliderGroupWidget extends StatelessWidget {
  const ColorSliderGroupWidget({required this.blocTheme, super.key});

  final BlocTheme blocTheme;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeModel>(
      stream: blocTheme.themeModelStream,
      builder: (_, __) {
        final Color currentColor = blocTheme.themeModel.color;

        return Column(
          children: <Widget>[
            BuildSliderWidget(
              label: 'R',
              value: currentColor.r,
              color: Colors.red,
              onChanged:
                  (double value) => blocTheme.updateColorComponent(red: value),
            ),
            BuildSliderWidget(
              label: 'G',
              value: currentColor.g,
              color: Colors.green,
              onChanged:
                  (double value) =>
                      blocTheme.updateColorComponent(green: value),
            ),
            BuildSliderWidget(
              label: 'B',
              value: currentColor.b,
              color: Colors.blue,
              onChanged:
                  (double value) => blocTheme.updateColorComponent(blue: value),
            ),
          ],
        );
      },
    );
  }
}

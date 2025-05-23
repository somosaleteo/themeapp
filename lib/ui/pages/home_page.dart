import 'package:flutter/material.dart';
import 'package:text_responsive/text_responsive.dart';

import '../../domain/models/theme_model.dart';
import '../app_state_manager.dart';
import '../widgets/color_slider_group_widget.dart';
import '../widgets/projector_widget.dart';
import '../widgets/theme_model_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const InlineTextWidget('Demo reactividad'),
      ),
      body: ProjectorWidget(
        designWidth: 440,
        designHeight: 956,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<ThemeModel>(
                stream: AppStateManager.of(context).blocTheme.themeModelStream,
                builder: (_, __) {
                  return ThemeModelCardWidget(
                    themeModel:
                        AppStateManager.of(context).blocTheme.themeModel,
                  );
                },
              ),
              SizedBox(
                width: 440.0,
                height: 300.0,
                child: ParagraphTextWidget(
                  'Si han pasado más de 5 segundos.\nPresiona el boton para cambiar el tema\nde lo contrario solo cambiará el modelo',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              // Sliders
              ColorSliderGroupWidget(
                blocTheme: AppStateManager.of(context).blocTheme,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: AppStateManager.of(context).blocTheme.changeToRandomTheme,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

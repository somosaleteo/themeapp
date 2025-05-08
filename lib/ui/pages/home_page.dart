import 'package:flutter/material.dart';
import 'package:text_responsive/text_responsive.dart';

import '../app_state_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const InlineTextWidget('Demo reactividad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InlineTextWidget(
              'Color: ${AppStateManager.of(context).blocTheme.themeModel.toJson()}',
            ),
            Text(
              'Presiona el boton para cambiar el tema',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: AppStateManager.of(context).blocTheme.changeToRandomTheme,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';

import '../blocs/bloc_theme.dart';

class AppStateManager extends InheritedWidget {
  const AppStateManager({
    required super.child,
    required this.blocTheme,
    super.key,
  });
  final BlocTheme blocTheme;
  static AppStateManager of(BuildContext context) {
    final AppStateManager? result =
        context.dependOnInheritedWidgetOfExactType<AppStateManager>();
    assert(result != null, 'No AppStateManager found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppStateManager old) {
    return false;
  }

  void dispose() {
    blocTheme.dispose();
  }
}

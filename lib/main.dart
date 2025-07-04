import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'blocs/bloc_theme.dart';
import 'data/gateways/theme/theme_gateway_firebase_impl.dart';
import 'data/repositories/theme/theme_repository_impl.dart';
import 'data/services/service_firebase_firestore_database.dart';
import 'domain/gateways/theme_gateway.dart';
import 'domain/usecases/theme/listen_to_theme_changes_usecase.dart';
import 'domain/usecases/theme/load_theme_usecase.dart';
import 'domain/usecases/theme/save_theme_usecase.dart';
import 'firebase_options.dart';
import 'ui/app_state_manager.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final ThemeGateway themeGateway = ThemeGatewayFakeImpl();

    // Esta no es soportada en Windows
    // final ThemeGateway themeGateway = ThemeGatewayFirebaseImpl(
    //   ServiceFirebaseRealtimeDatabase(),
    // );

    final ThemeGateway themeGateway = ThemeGatewayFirebaseImpl(
      ServiceFirebaseFirestoreDatabase(),
    );

    final ThemeRepositoryImpl testRepository = ThemeRepositoryImpl(
      gateway: themeGateway,
    );
    final BlocTheme blocTheme = BlocTheme(
      saveThemeUseCase: SaveThemeUseCase(testRepository),
      loadThemeUseCase: LoadThemeUseCase(testRepository),
      listenToThemeChangesUseCase: ListenToThemeChangesUseCase(testRepository),
    );
    return AppStateManager(
      blocTheme: blocTheme,
      child: StreamBuilder<ThemeData>(
        stream: blocTheme.themeStream,
        builder: (_, __) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: blocTheme.themeData,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

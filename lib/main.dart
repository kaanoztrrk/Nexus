// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexus/Pages/Auth/Splash.dart';
import 'package:nexus/Util/TextStorge.dart';
import 'Providers/ProfileManager_Notifier.dart';
import 'Util/Theme.dart';
import 'package:firebase_core/firebase_core.dart';

final profileManagerProvider = Provider((ref) => ProfileManager());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(child: Nexus()),
  );
}

class Nexus extends ConsumerWidget {
  const Nexus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var darkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      title: TextStorge.appName,
      theme: AppThemeClass.ligthTheme,
      darkTheme: AppThemeClass.darkTheme,
      // darkMode ? ThemeMode.light : ThemeMode.dark,
      themeMode: ThemeMode.dark,

      home: const SplashPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // Add more cases for additional routes as needed
          default:
            // Handle unknown routes
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}

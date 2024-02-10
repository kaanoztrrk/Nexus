import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexus/Pages/Auth/Splash.dart';
import 'package:nexus/Pages/Settings.dart';
import 'Pages/Apps/Apps.dart';
import 'Pages/Home.dart';
import 'Providers/ProfileManager_Notifier.dart';
import 'Util/Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final profileManagerProvider = Provider((ref) => ProfileManager());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
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
      title: 'Nexus AI',
      theme: AppThemeClass.ligthTheme,
      darkTheme: AppThemeClass.darkTheme,
      // darkMode ? ThemeMode.light : ThemeMode.dark,
      themeMode: ThemeMode.dark,
      home: const SplashPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsPage());
          case '/apps':
            return MaterialPageRoute(builder: (_) => const AppsPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => const Home());
          // Add more cases for additional routes as needed
          default:
            // Handle unknown routes
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}

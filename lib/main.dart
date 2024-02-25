// Bu satır, linting kurallarını geçersiz kılmanızı sağlar
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Providers/ProfileManager_Notifier.dart';
import 'Util/Theme.dart';
import 'Util/TextStorge.dart';
import 'Pages/Auth/Splash.dart';

final profileManagerProvider = Provider((ref) => ProfileManager());

void main() async {
  // Firebase ve Hive'ı başlatın
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Uygulamayı çalıştırın
  runApp(
    const ProviderScope(child: Nexus()),
  );
}

class Nexus extends ConsumerWidget {
  const Nexus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dark mode durumunu alın
    // final darkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      title: TextStorge.appName,
      theme: AppThemeClass.ligthTheme,
      darkTheme: AppThemeClass.darkTheme,
      // themeMode: darkMode ? ThemeMode.light : ThemeMode.dark,
      themeMode: ThemeMode.dark,

      home: const SplashPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // Ek rotalar için ek case'ler ekleyin
          default:
            // Bilinmeyen rotaları ele alın
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}

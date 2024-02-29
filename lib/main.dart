// Bu satır, linting kurallarını geçersiz kılmanızı sağlar
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Util/Theme.dart';
import 'Util/TextStorge.dart';
import 'Pages/Auth/Splash.dart';

void main() async {
  // Firebase ve Hive'ı başlatın
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Uygulamayı çalıştırın
  runApp(
    const Nexus(),
  );
}

class Nexus extends StatelessWidget {
  const Nexus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextStorge.appName,
      theme: AppThemeClass.ligthTheme,
      darkTheme: AppThemeClass.darkTheme,
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

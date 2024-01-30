import 'package:external_app_launcher/external_app_launcher.dart';

class AppLauncher {
  static Future<void> launchApp(String packageName) async {
    try {
      await LaunchApp.openApp(
        androidPackageName: packageName,
        openStore: false,
      );
    } catch (e) {
      print('Uygulama açma hatası: $e');
    }
  }
}

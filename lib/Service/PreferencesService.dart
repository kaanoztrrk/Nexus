import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Örnek bir veri kaydetme fonksiyonu
  Future<void> setStringValue(String key, String value) async {
    await _preferences!.setString(key, value);
  }

  Future<void> setIntValue(String key, int value) async {
    await _preferences!.setInt(key, value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences!.setBool(key, value);
  }

  // Örnek bir veri okuma fonksiyonu
  dynamic getValue(String key) {
    return _preferences!.get(key);
  }

  // Örnek bir veri silme fonksiyonu
  Future<void> removeValue(String key) async {
    await _preferences!.remove(key);
  }
}

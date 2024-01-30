import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssistantVoiceSettings {
  FlutterTts flutterTts = FlutterTts();

  String language = 'en'; // Varsayılan dil
  double volume = 1.0;
  double pitch = 0.8;
  double rate = 0.8; // Ses hızı

  Future<void> setLanguage(String lang) async {
    language = lang;
    await flutterTts.setLanguage(language);
  }

  Future<void> setVolume(double vol) async {
    volume = vol;
    await flutterTts.setVolume(volume);
  }

  Future<void> setPitch(double p) async {
    pitch = p;
    await flutterTts.setPitch(pitch);
  }

  Future<void> setSpeechRate(double r) async {
    rate = r;
    await flutterTts.setSpeechRate(rate);
  }

  Future<void> saveConfiguration() async {
    // Ses ayarlarını kaydet
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    prefs.setDouble('volume', volume);
    prefs.setDouble('pitch', pitch);
    prefs.setDouble('rate', rate);
  }

  Future<void> loadConfiguration() async {
    // Ses ayarlarını yükle
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language') ?? 'en';
    volume = prefs.getDouble('volume') ?? 1.0;
    pitch = prefs.getDouble('pitch') ?? 0.8;
    rate = prefs.getDouble('rate') ?? 0.8;
  }

  Future<void> initializeAssistant() async {
    // Asistanı başlat
    await loadConfiguration();
    await setLanguage(language);
    await setVolume(volume);
    await setPitch(pitch);
    await setSpeechRate(rate);
  }
}

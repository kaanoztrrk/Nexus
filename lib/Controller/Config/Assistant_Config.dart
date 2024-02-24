// ignore_for_file: file_names, avoid_print

import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AssistantConfig {
  final FlutterTts flutterTts = FlutterTts();
  final SpeechToText speechToText = SpeechToText();

  Future<void> configureTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(0.8);
  }

  Future<void> speechStateConfig() async {
    bool isAvailable = await speechToText.initialize(
      onStatus: (status) {
        print('Speech recognition status: $status');
      },
      onError: (errorNotification) {
        print('Speech recognition error: $errorNotification');
      },
    );

    if (!isAvailable) {
      print('Speech recognition is not available.');
    }
  }

  Future<void> initializeAssistant() async {
    DateTime now = DateTime.now();
    configureTts();
    int currentHour = now.hour;

    if (currentHour >= 5 && currentHour < 12) {
      await flutterTts.speak("Good morning!");
    } else if (currentHour >= 12 && currentHour < 18) {
      await flutterTts.speak("Good afternoon!");
    } else {
      await flutterTts.speak("Good evening!");
    }
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'Config/Assistant_Memory.dart';

class Apps {
  final PageController pageController = PageController(initialPage: 0);

  void howCanYouDo(SpeechRecognitionResult result, BuildContext context) {
    String spokenSearch = result.recognizedWords.toLowerCase();
    if (spokenSearch.contains('how can you do')) {
      //  pageNavigator(context, const AppsPage());
    }
  }

  void note(SpeechRecognitionResult result, BuildContext context) {
    String spokenSearch = result.recognizedWords.toLowerCase();
    if (spokenSearch.contains('writing')) {
      //   pageNavigator(context, const SettingsPage());
    }
  }

  void settings(SpeechRecognitionResult result, BuildContext context) {
    String spokenSearch = result.recognizedWords.toLowerCase();
    if (spokenSearch.contains('setting')) {
      //   pageNavigator(context, const SettingsPage());
    }
  }

  void calendar(SpeechRecognitionResult result, BuildContext context) {
    String spokenSearch = result.recognizedWords.toLowerCase();
    if (spokenSearch.contains('dictionary')) {
      //  pageNavigator(context, DictionaryScreen());
    }
  }
}

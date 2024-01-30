// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'PageNavigator.dart';

Future<void> speakMethod(
  String speakMethod,
  Widget page,
  SpeechRecognitionResult result,
  BuildContext context,
) async {
  String spokenSearch = result.recognizedWords.toLowerCase();
  if (spokenSearch.contains(speakMethod)) {
    await pageNavigator(context, page);
  }
}

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../Controller/AppsController.dart';
import '../../Controller/Config/Asisstant_Dialog.dart';

class SpeechService {
  late stt.SpeechToText _speech;
  late BuildContext _context;
  late VoiceDialog _voiceDialog;
  Apps apps = Apps();

  SpeechService(BuildContext context) {
    _context = context;
    _speech = stt.SpeechToText();
    _voiceDialog = VoiceDialog();
  }

  void listenForSpeech(void Function(String) onResult) async {
    if (_speech.isAvailable) {
      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);

            _voiceDialog.handleCommand(result.recognizedWords);

            Future.delayed(const Duration(seconds: 2), () {
              onResult("");
            });
          }
        },
      );
    }
  }
}

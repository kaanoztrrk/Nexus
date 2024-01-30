import 'package:flutter_tts/flutter_tts.dart';

class VoiceDialog {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> handleCommand(String command) async {
    final cleanCommand = command.toLowerCase().trim();

    switch (cleanCommand) {
      case "hello":
        await speak("Hello! How can I help you?");
        break;
      case "time":
        await speak("The current time is ${DateTime.now().toString()}");
        break;
      case "open calendar":
        // TODO: Implement code to open the calendar
        await speak("Opening the calendar.");
        break;
      case "play music":
        // TODO: Implement code to play music
        await speak("Playing your favorite music.");
        break;
      default:
        await speak("Sorry, I didn't understand that command.");
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }
}

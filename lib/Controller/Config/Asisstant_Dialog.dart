import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoiceDialog {
  final FlutterTts flutterTts = FlutterTts();
  final CollectionReference assistantDataCollection =
      FirebaseFirestore.instance.collection('assistant_data');

  // Hafıza (Memory) tanımlaması
  final Map<String, String> memory = {};

  Future<void> handleCommand(String command) async {
    final cleanCommand = command.toLowerCase().trim();

    // Ön kontrol: Boş bir komut mu kontrol et
    if (cleanCommand.isEmpty) {
      await speak("Sorry, I didn't catch that. Can you please repeat?");
      return;
    }

    try {
      // Firestore'dan belirli bir terimi çekme
      DocumentSnapshot termDoc =
          await assistantDataCollection.doc(cleanCommand).get();

      if (termDoc.exists) {
        // Terim varsa, bilgiyi al ve hafızaya ekle
        String information = termDoc.get('information') as String;
        memory[cleanCommand] = information;
        await speak(information);
      } else {
        // Terim yoksa, hafızadan kontrol et
        if (memory.containsKey(cleanCommand)) {
          String? response = memory[cleanCommand];
          await speak(response!);
        } else {
          // Hafızada da yoksa, genel bir mesaj ver
          await speak(getGeneralResponse(cleanCommand));
        }
      }
    } catch (e) {
      print("Error handling command: $e");
    }
  }

  Future<void> speak(String text) async {
    if (text != null) {
      await flutterTts.speak(text);
    } else {
      print("Error: Tried to speak null text.");
    }
  }

  String getGeneralResponse(String command) {
    // Genel bir cevap seçmek için
    switch (command) {
      case 'hello':
        return "Hello! How can I help you?";
      case 'time':
        return "The current time is ${DateTime.now().toString()}";
      case 'open calendar':
        // TODO: Implement code to open the calendar
        return "Opening the calendar.";
      case 'play music':
        // TODO: Implement code to play music
        return "Playing your favorite music.";
      default:
        return "I'm not sure how to respond to that command.";
    }
  }
}

// ignore_for_file: unnecessary_null_comparison, avoid_print, file_names
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Service/AssistantService/DataResponse.dart';

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
          await speak(getGeneralResponse(cleanCommand) ?? "");
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

  String? getGeneralResponse(String command) {
    // Genel bir cevap seçmek için
    switch (command) {
      case 'hello':
      case 'hey':
      case 'howdy':
      case 'greetings':
      case 'good morning':
      case 'good afternoon':
      case 'good evening':
      case 'hi there':
      case 'hiya':
      case 'sup':
        return DataResponseService.responseReturn("greeting");
      case 'time':
      case 'what time ':
      case 'what time is it':
      case "do you know what time it is":
      case "what is the current time":
        return DataResponseService.responseReturn("time");
      case 'what is the date today':
      case 'what day is it today':
      case 'could you tell me the date, please':
      case "do you know what todays date is":
      case 'could you inform me of the date':
        return DataResponseService.responseReturn("dataTime");
      default:
        return DataResponseService.defaultResponse();
    }
  }
}

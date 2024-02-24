import 'dart:math';
import 'package:intl/intl.dart';

class DataResponseService {
  // Komutlara göre tarih ve saat cevaplarını içeren bir map
  static Map<String, List<String>> commandResponsesMap = {
    'dateTime': [
      "Today is ${DateFormat.yMMMMd('en_US').format(DateTime.now())}.",
      "Today is ${DateFormat.EEEE('en_US').format(DateTime.now())}.",
      "Today's date is ${DateFormat.yMMMMd('en_US').format(DateTime.now())}.",
      "The date today is ${DateFormat.yMMMMd('en_US').format(DateTime.now())}.",
      "The current date is ${DateFormat.MMMMEEEEd('en_US').format(DateTime.now())}.",
      "It's ${DateFormat.yMd('en_US').format(DateTime.now())}.",
      "The date today is ${DateFormat.yMMMMEEEEd('en_US').format(DateTime.now())}."
    ],
    'time': [
      "The current time is ${DateFormat('kk:mm').format(DateTime.now())}.",
      "It's ${DateFormat('h:mm a').format(DateTime.now())}.",
      "The time is now ${DateFormat('h:mm a').format(DateTime.now())}.",
      "The current time is ${DateFormat('kk:mm').format(DateTime.now())}.",
      "It's ${DateFormat('kk:mm').format(DateTime.now())}.",
    ],
    'greeting': [
      "Hello Sir! How can I assist you today?",
      "Hi there, Boss! What can I do for you?",
      "Good day Sir! How may I help you today?",
      "Greetings, Boss! What do you need from me?",
      "Hello there! How can I be of service?",
      "Good morning Sir! What can I do for you today?",
      "Hi there! How may I assist you today?",
      "Good day! What can I help you with, Sir?",
      "Hello! How can I assist you, Boss?",
      "Hi there, Sir! What do you need from me?",
    ],
    'default': [
      "I'm not sure how to respond to that command.",
      "Sorry, I didn't quite catch that.",
      "Could you please repeat that?",
      "I'm still learning. Could you try another command?",
    ],
    // Daha fazla komutlar buraya eklenebilir
  };

  // Belirli bir komuta göre rastgele bir cevap döndüren fonksiyon
  static String? responseReturn(String command) {
    List<String>? responses = commandResponsesMap[command];
    if (responses != null && responses.isNotEmpty) {
      Random random = Random();
      return responses[random.nextInt(responses.length)];
    } else {
      // Belirli bir komuta karşılık gelen cevap yoksa varsayılan cevap döndürülür
      return defaultResponse();
    }
  }

  // Varsayılan cevap döndüren fonksiyon
  static String defaultResponse() {
    Random random = Random();
    List<String>? defaultResponses = commandResponsesMap['default'];
    if (defaultResponses != null && defaultResponses.isNotEmpty) {
      return defaultResponses[random.nextInt(defaultResponses.length)];
    } else {
      return "I'm not sure how to respond to that command.";
    }
  }
}

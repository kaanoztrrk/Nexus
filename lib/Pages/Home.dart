// ignore_for_file: file_names, prefer_const_constructor, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexus/Controller/Config/Assistant.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';
import 'package:nexus/Widget/Text/AnimatedText.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/TextField/CustomTextField.dart';
import 'package:nexus/Widget/Button/OutlineBorderButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../Controller/AppsController.dart';
import '../Controller/AppsListController.dart';
import '../Controller/Config/Asisstant_Dialog.dart';
import '../Controller/Config/Assistant_Config.dart';

import '../Providers/ProfileManager_Notifier.dart';
import '../Util/Colors.dart';
import '../Util/Extension/PageNavigator.dart';
import '../Util/Extension/Size.dart';
import '../Widget/Button/VoiceButton.dart';

final profileManagerProvider = Provider((ref) => ProfileManager());

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  VoiceDialog voiceDialog = VoiceDialog();
  int selectedImageIndex = 0;
  late stt.SpeechToText _speech;
  final String user = "Hi, Theviacoder";
  String _recognizedText = "";
  final Apps _apps = Apps();

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
            }));
  }

  @override
  void initState() {
    super.initState();
    config();
    getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: VoiceButton(onTap: speechListining),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: displayHeight(context) * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CustomAvatar(size: 0.175),
              _user(user),
              _title(),
              Expanded(
                flex: 8,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(
                      AppsListController().bgList[selectedImageIndex]),
                ))),
              ),
              Expanded(
                flex: 2,
                child: AnimatedText(text: _recognizedText),
              )
            ],
          ),
        ),
      ),
    );
  }

  void config() {
    _speech = stt.SpeechToText();
    AssistantConfig().speechStateConfig();
    AssistantConfig().initializeAssistant();
    AssistantConfig().configureTts();
  }

  void speechListining() {
    if (_speech.isAvailable) {
      _speech.listen(
        onResult: (result) async {
          if (result.finalResult) {
            setState(() {
              _recognizedText = result.recognizedWords;
            });

            voiceDialog.handleCommand(_recognizedText);

            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _recognizedText = "";
              });
            });
          }
        },
      );
    }
  }

  Widget _user(String user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        user,
        style: customGoogleTextStyle().copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      text: TextSpan(
          text: "I can help you with ",
          style: customGoogleTextStyle().copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColor().white.withOpacity(0.7)),
          children: [
            TextSpan(
                text: "something?",
                style: customGoogleTextStyle().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor().white)),
          ]),
    );
  }
}

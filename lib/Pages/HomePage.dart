// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Models/Users.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../Controller/AppsListController.dart';
import '../Controller/Config/Asisstant_Dialog.dart';
import '../Util/Colors.dart';
import '../Util/Extension/Size.dart';
import '../Util/Extension/TextUtility.dart';
import '../Widget/Button/VoiceButton.dart';
import '../Widget/Components/Avatar.dart';
import '../Widget/Text/AnimatedText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});

  final UserProfile user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VoiceDialog voiceDialog = VoiceDialog();

  int selectedImageIndex = 0;
  String _recognizedText = "";
  late stt.SpeechToText _speech;

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
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
              _user("Hi, ${user.firstName}"),
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

  void speechListining() {
    if (_speech.isAvailable) {
      _speech.listen(
        onResult: (result) async {
          if (result.finalResult) {
            setState(() {
              _recognizedText = result.recognizedWords;
            });

            voiceDialog.handleCommand(_recognizedText);

            Future.delayed(const Duration(seconds: 2), () {
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

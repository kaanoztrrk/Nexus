import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'Controller/AppsController.dart';
import 'Controller/AppsListController.dart';
import 'Controller/Config/Asisstant_Dialog.dart';
import 'Controller/Config/Assistant_Config.dart';
import 'Controller/Config/Assistant_Memory.dart';
import 'Models/Users.dart';
import 'Service/AssistantService/SpeechService.dart';
import 'Util/Colors.dart';
import 'Util/Extension/Size.dart';
import 'Util/Extension/TextUtility.dart';
import 'Widget/Button/VoiceButton.dart';
import 'Widget/Components/Avatar.dart';
import 'Widget/AnimatedText.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late stt.SpeechToText _speech;
  UserProfile? userProfile;
  late SpeechService _speechService;
  VoiceDialog voiceDialog = VoiceDialog();

  int selectedImageIndex = 0;
  String _recognizedText = "";

  @override
  void initState() {
    super.initState();
    config();
    _getUserData(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    if (userProfile != null) {
      return PopScope(
        canPop: false,
        child: Scaffold(
          bottomNavigationBar: VoiceButton(
            onTap: () => speechListening(),
            user: userProfile!,
            userID: widget.userID,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: displayHeight(context) * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _user("Hi, ${userProfile!.firstName}"),
                  _title(),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(
                            AppsListController().bgList[selectedImageIndex],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AnimatedText(text: _recognizedText),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  void speechListening() {
    _speechService.listenForSpeech((result) {
      // Konuşma tanıma sonuçlarını işleyin

      setState(() {
        // Duruma göre işlem yapın
        _recognizedText = result;
      });
    });
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
          color: AppColor().white.withOpacity(0.7),
        ),
        children: [
          TextSpan(
            text: "something?",
            style: customGoogleTextStyle().copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColor().white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getUserData(String userID) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();

      if (userSnapshot.exists) {
        userProfile =
            UserProfile.fromMap(userSnapshot.data() as Map<String, dynamic>);
        setState(() {});
      } else {
        print('User data not found.');
      }
    } catch (error) {
      print('Error retrieving user data: $error');
    }
  }

  void config() {
    _speech = stt.SpeechToText();
    _speechService = SpeechService(context);
    AssistantConfig().speechStateConfig();
    selectedImage();
    AssistantConfig().configureTts();
  }

  Future<void> selectedImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? selectedIndex = preferences.getInt('selectedImageIndex');
    selectedImageIndex = selectedIndex ?? 0;
  }
}

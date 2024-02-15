// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field, avoid_print
// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'Controller/Config/Assistant_Config.dart';
import 'Models/Users.dart';
import 'Pages/HomePage.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userID});
  final String userID;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late stt.SpeechToText _speech;
  UserProfile? _userProfile;
  String? _profileImage;

  @override
  void initState() {
    super.initState();
    config();
    _getUserData(widget.userID);
    _getProfileImage();
  }

  Future<void> _getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImage = prefs.getString('profileImage');
      if (_userProfile != null && _profileImage != null) {
        _userProfile!.profileImage = _profileImage!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _userProfile != null
        ? HomePage(user: _userProfile!)
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Future<void> _getUserData(String userID) async {
    try {
      // Kullanıcı verilerini Firestore'dan al
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();

      // Eğer belirli bir kullanıcıya ait veriler varsa
      if (userSnapshot.exists) {
        // Kullanıcı profiline atama yap
        _userProfile =
            UserProfile.fromMap(userSnapshot.data() as Map<String, dynamic>);
        // setState çağırarak yeniden build et
        setState(() {});
      } else {
        // Belirli bir kullanıcıya ait veriler bulunamadı
        print('User data not found.');
      }
    } catch (error) {
      // Hata durumunda yapılacak işlemler
      print('Error retrieving user data: $error');
    }
  }

  void config() {
    _speech = stt.SpeechToText();
    AssistantConfig().speechStateConfig();
    // AssistantConfig().initializeAssistant();
    AssistantConfig().configureTts();
  }
}

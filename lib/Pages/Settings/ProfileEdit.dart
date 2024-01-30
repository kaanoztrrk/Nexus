import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Widget/Button/ClassicButton.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/Components/BirthDaySelecter.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import 'package:nexus/Widget/TextField/CustomTextField.dart';

import '../../Util/Colors.dart';
import '../../Widget/Components/GenderSelecter.dart';
import '../../Widget/TextField/CustomTextField_Edit.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedGender = '';
  int currentIndex = 0;
  String selectedBirthDay = "";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController appealController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomAppbar(title: "Profile Edit"),
      ),
      body: Column(
        children: [
          const Expanded(
              flex: 25,
              child: Center(
                child: CustomAvatar(size: 0.25),
              )),
          Expanded(
            flex: 75,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextField_Edit(
                    controller: fullNameController,
                    hintText: "Full Name",
                  ),
                  CustomTextField_Edit(
                    controller: appealController,
                    hintText: "Assistant Appeal",
                  ),
                  CustomTextField_Edit(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  CustomTextField_Edit(
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  GenderSelector(),
                  BirthdaySelector(
                    onDateSelected: (date) {
                      selectedBirthDay = date.toString();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomClassicButton(
                      title: "Save",
                      bgColor: AppColor().white,
                      color: AppColor().bgColor,
                      onTap: () => _saveProfileInfo(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfileInfo() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(fullNameController.text);
        await user.updateEmail(emailController.text);

        // Kullanıcı bilgilerini Firestore'da users koleksiyonuna ekleyin
        await _firestore.collection('users').doc(user.uid).set({
          'full_name': fullNameController.text,
          'assistant_appeal': appealController.text,
          'email': emailController.text,
          'gender': selectedGender,
          'birthday': selectedBirthDay, // Buraya seçilen tarih gelecek
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile information saved successfully!"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
        ),
      );
    }
  }
}

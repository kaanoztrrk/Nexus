// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Models/Users.dart';
import 'package:nexus/Service/ScaffoldMessage.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Button/ClassicButton.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import 'package:nexus/Widget/CustomTextField.dart';
import 'package:restart_app/restart_app.dart';
import '../../Util/Colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key, this.user, this.userID});

  final UserProfile? user;
  final String? userID;

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String selectedGender = '';
  int currentIndex = 0;
  String selectedBirthDay = "";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Controller'ları başlatma işlemi initState içinde yapılıyor
    // Ve widget özelliğinden erişim sağlanıyor
    firstNameController.text = widget.user?.firstName ?? '';
    lastNameController.text = widget.user?.lastName ?? '';
    emailController.text = widget.user?.email ?? '';
    ageController.text = widget.user?.age ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppbar(
          title: "Profile Edit",
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(displayWidth(context) * 0.1),
            child: CustomAvatar(size: 0.25),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _textField(
                  hintText: widget.user?.firstName,
                  controller: firstNameController,
                ),
                _textField(
                  hintText: widget.user?.lastName,
                  controller: lastNameController,
                ),
                _textField(
                  hintText: widget.user?.email,
                  controller: emailController,
                ),
                _textField(
                  hintText: widget.user?.age,
                  controller: ageController,
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomClassicButton(
              title: "Save",
              onTap: () => updateUserData(
                  context: context,
                  userID: widget.userID,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  age: ageController.text),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateUserData({
    String? userID,
    String? firstName,
    String? lastName,
    String? email,
    String? age,
    required BuildContext context,
  }) async {
    try {
      // Kullanıcının verilerini güncelle Firestore'da
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();

      Map<String, dynamic> updatedData = {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (email != null) 'email': email,
        if (age != null) 'age': age,
      };

      // Mevcut kullanıcı verilerini güncelle
      if (userSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .update(updatedData);
      } else {
        // Kullanıcı bulunamadı
        print('User not found.');
        SnackBarService.showSnackBar(context, "User not found.");
        return;
      }

      SnackBarService.showSnackBar(context, "Your Profile has been Updated.");
      Restart.restartApp(webOrigin: "_");
    } catch (error) {
      print('Error updating user data: $error');
      SnackBarService.showSnackBar(
          context, "An error occurred while updating your profile");
    }
  }

  Widget _textField({String? hintText, TextEditingController? controller}) {
    return CustomTextField(
      color: AppColor().white.withOpacity(0.7),
      controller: controller,
      hintText: hintText,
    );
  }
}

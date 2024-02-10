// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus/Service/ScaffoldMessage.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import 'package:nexus/Widget/Components/GenderSelecter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Util/Colors.dart';
import '../../../Util/Extension/ImageExtension.dart';
import '../../../Util/Extension/Size.dart';
import '../../../Util/Extension/TextUtility.dart';
import '../../../Widget/Button/ClassicButton.dart';
import '../../../Widget/TextField/CustomTextField.dart';

class UserStartProfilePage extends StatefulWidget {
  @override
  _UserStartProfilePageState createState() => _UserStartProfilePageState();
}

class _UserStartProfilePageState extends State<UserStartProfilePage> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  void nextPage(TextEditingController controller) {
    if (controller.text == "") {
      SnackBarService.showSnackBar(context, "Please do not leave it blank.");
    } else {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  File? image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveUserData() {
    FirebaseFirestore.instance.collection('users').add({
      'firstName': _nameController.text,
      'lastName': _lastNameController.text,
      'age': int.tryParse(_ageController.text) ?? 0,
      'gender': _genderController.text,
      // Burada profil resminin URL'sini eklemek istiyorsanız, onu da ekleyebilirsiniz.
    }).then((value) {
      print('User added with ID: ${value.id}');
      // Veri başarıyla eklendiğinde yapılacak işlemler buraya gelebilir.
    }).catchError((error) {
      print('Failed to add user: $error');
      // Hata durumunda yapılacak işlemler buraya gelebilir.
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _stepFirstname(),
            _stepLastName(),
            _stepAge(),
            _stepGender(),
            _stepProfileImage(image),
          ],
        ),
      ),
    );
  }

  Widget _stepFirstname() {
    return Container(
      child: Column(
        children: [
          CustomAppbar(),
          Image(
              width: displayWidth(context) * 0.2,
              color: AppColor().white.withOpacity(0.7),
              image: IconImageEnum.user.toPath),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "What's your first name ?",
              style: customGoogleTextStyle(
                  fontWeight: FontWeight.bold,
                  size: 24,
                  color: AppColor().white.withOpacity(0.7)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomTextField(
                hintText: "First Name", controller: _nameController),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomClassicButton(
              title: "Next",
              onTap: () => nextPage(_nameController),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepLastName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAppbar(
          leading: IconButton(
            onPressed: previousPage,
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Image(
            width: displayWidth(context) * 0.2,
            color: AppColor().white.withOpacity(0.7),
            image: IconImageEnum.user.toPath),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "What's your last name ?",
            style: customGoogleTextStyle(
                fontWeight: FontWeight.bold,
                size: 24,
                color: AppColor().white.withOpacity(0.7)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomTextField(
              hintText: "Last Name", controller: _lastNameController),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomClassicButton(
              title: "Next", onTap: () => nextPage(_lastNameController)),
        ),
      ],
    );
  }

  Widget _stepAge() {
    return Column(
      children: [
        CustomAppbar(
          leading: IconButton(
            onPressed: previousPage,
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Image(
            width: displayWidth(context) * 0.2,
            color: AppColor().white.withOpacity(0.7),
            image: IconImageEnum.user.toPath),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "How old are you ?",
            style: customGoogleTextStyle(
                fontWeight: FontWeight.bold,
                size: 24,
                color: AppColor().white.withOpacity(0.7)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomTextField(
            keyboardType: TextInputType.datetime,
            hintText: "Age",
            controller: _ageController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2)
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomClassicButton(
            title: "Next",
            onTap: () => nextPage(_ageController),
          ),
        ),
      ],
    );
  }

  Widget _stepGender() {
    return Column(
      children: [
        CustomAppbar(
          leading: IconButton(
            onPressed: previousPage,
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Image(
            width: displayWidth(context) * 0.2,
            color: AppColor().white.withOpacity(0.7),
            image: IconImageEnum.user.toPath),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "What is your gender ?",
            style: customGoogleTextStyle(
                fontWeight: FontWeight.bold,
                size: 24,
                color: AppColor().white.withOpacity(0.7)),
          ),
        ),
        GenderSelector(
          onChanged: (selectedGender) {
            _genderController.text = selectedGender;
            print(_genderController.text);
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomClassicButton(
              title: "Next", onTap: () => nextPage(_genderController)),
        ),
      ],
    );
  }

  Widget _stepProfileImage(File? image) {
    return Column(
      children: [
        CustomAppbar(),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CustomAvatar(
              size: 0.275,
              image: image == null
                  ? Image(image: AssetImage("assets/Profile.jpg"), width: 0.275)
                  : Image.file(image, width: displayWidth(context) * 0.25),
              func: getImage,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: displayWidth(context) * 0.1,
              height: displayHeight(context) * 0.03,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor().white,
              ),
              child: Image(
                image: IconImageEnum.edit.toPath,
                color: AppColor().bgColor,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Please choose your\n profile photo",
            textAlign: TextAlign.center,
            style: customGoogleTextStyle(
              fontWeight: FontWeight.bold,
              size: 24,
              color: AppColor().white.withOpacity(0.7),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomClassicButton(
            title: "Start Nexus",
            onTap: () => _saveUserData(),
          ),
        ),
      ],
    );
  }
}

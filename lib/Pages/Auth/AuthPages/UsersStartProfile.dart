// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, file_names, library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus/Service/ScaffoldMessage.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import 'package:nexus/Widget/Components/GenderSelecter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Service/ImageStorage.dart';
import '../../../Util/Colors.dart';
import '../../../Util/Extension/ImageExtension.dart';
import '../../../Util/Extension/Size.dart';
import '../../../Util/Extension/TextUtility.dart';
import '../../../Widget/Button/ClassicButton.dart';
import '../../../Widget/CustomTextField.dart';

class UserStartProfilePage extends StatefulWidget {
  const UserStartProfilePage(
      {super.key, required this.email, required this.password});
  final String email;
  final String password;
  @override
  _UserStartProfilePageState createState() => _UserStartProfilePageState();
}

class _UserStartProfilePageState extends State<UserStartProfilePage> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
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

  void _saveUserData(BuildContext context) async {
    String email = widget.email;
    String password = widget.password;
    String firstName = _nameController.text;
    String lastName = _lastNameController.text;
    String age = _birthDayController.text;
    String gender = _genderController.text;

    // Kullanıcı verilerini kaydet
    await UserDataStorage.saveUserData(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      image: image,
      context: context,
    );
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
            _stepBirtDay(),
            _stepGender(),
            _stepProfileImage(image),
          ],
        ),
      ),
    );
  }

  Widget _stepFirstname() {
    return Column(
      children: [
        const CustomAppbar(),
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
    );
  }

  Widget _stepLastName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAppbar(
          leading: IconButton(
            onPressed: previousPage,
            icon: const Icon(Icons.arrow_back),
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

  Widget _stepBirtDay() {
    return Column(
      children: [
        CustomAppbar(
          leading: IconButton(
            onPressed: previousPage,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        Image(
            width: displayWidth(context) * 0.2,
            color: AppColor().white.withOpacity(0.7),
            image: IconImageEnum.user.toPath),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "When were you born ?",
            style: customGoogleTextStyle(
                fontWeight: FontWeight.bold,
                size: 24,
                color: AppColor().white.withOpacity(0.7)),
          ),
        ),
        // birth day picker
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BirthdayPicker(
            controller: _birthDayController,
            initialDate: DateTime.now(),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomClassicButton(
            title: "Next",
            onTap: () => nextPage(_birthDayController),
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
            icon: const Icon(Icons.arrow_back),
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
        const CustomAppbar(),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CustomAvatar(
              size: 0.275,
              image: image == null
                  ? const Image(
                      image: AssetImage("assets/Profile.jpg"), width: 0.275)
                  : Image.file(image, width: displayWidth(context) * 0.25),
              func: getImage,
            ),
            Container(
              padding: const EdgeInsets.all(5),
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
            onTap: () => _saveUserData(context),
          ),
        ),
      ],
    );
  }
}

class BirthdayPicker extends StatelessWidget {
  final TextEditingController controller;
  final DateTime initialDate;

  const BirthdayPicker({
    Key? key,
    required this.controller,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextField(
          hintText: "BirthDay",
          controller: controller,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != initialDate) {
      controller.text = '${picked.year}-${picked.month}-${picked.day}';
    }
  }
}

void main() {
  TextEditingController birthdayController = TextEditingController();
  DateTime initialDate = DateTime.now();

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Birthday Picker')),
      body: Center(
        child: BirthdayPicker(
          controller: birthdayController,
          initialDate: initialDate,
        ),
      ),
    ),
  ));
}

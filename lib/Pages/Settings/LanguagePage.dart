import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';
import 'package:nexus/Widget/Button/ClassicButton.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  Color selectedColor = AppColor().white;
  Color unselectedColor = AppColor().crdColor;
  Color selectedTextColor = AppColor().bgColor;
  Color unselectedTextColor = AppColor().white;

  void _selectLanguage(String language) {
    setState(() {
      if (language == "English") {
        selectedColor = AppColor().white;
        unselectedColor = AppColor().crdColor;
        selectedTextColor = AppColor().bgColor;
        unselectedTextColor = AppColor().white;
      } else if (language == "Türkçe") {
        selectedColor = AppColor().crdColor;
        unselectedColor = AppColor().white;
        selectedTextColor = AppColor().white;
        unselectedTextColor = AppColor().bgColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Language",
          style: customGoogleTextStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomClassicButton(
              title: "English",
              bgColor: selectedColor,
              color: selectedTextColor,
              onTap: () {
                _selectLanguage("English");
              },
            ),
            SizedBox(height: 16),
            CustomClassicButton(
              title: "Türkçe",
              bgColor: unselectedColor,
              color: unselectedTextColor,
              onTap: () {
                _selectLanguage("Türkçe");
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';

class NumericKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;

  const NumericKeyboard({
    Key? key,
    required this.onKeyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        10,
        (index) {
          if (index == 9) {
            // 0 tuşu
            return _buildKeyboardButton('0');
          } else {
            // Diğer rakam tuşları
            return _buildKeyboardButton((index + 1).toString());
          }
        },
      )..add(
          _buildBackspaceButton(),
        ),
    );
  }

  Widget _buildKeyboardButton(String keyValue) {
    return TextButton(
      onPressed: () => onKeyPressed(keyValue),
      child: Text(
        keyValue,
        style: customGoogleTextStyle(
            color: AppColor().white, fontWeight: FontWeight.bold, size: 24),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return IconButton(
      icon: const Icon(Icons.backspace),
      onPressed: () => onKeyPressed('backspace'),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Util/Colors.dart';
import '../../Util/Extension/Size.dart';
import '../../Util/Extension/TextUtility.dart';

class CustomClassicButton extends StatelessWidget {
  const CustomClassicButton({
    super.key,
    required this.title,
    this.color,
    this.onTap,
    this.bgColor,
  });

  final String title;
  final Color? color;
  final Color? bgColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: displayHeight(context) * 0.025),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor ?? AppColor().white,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          title,
          style: customGoogleTextStyle(color: color ?? AppColor().bgColor),
        ),
      ),
    );
  }
}

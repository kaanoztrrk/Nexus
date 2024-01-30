// ignore_for_file: file_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Util/Colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.visible,
    this.onTap,
    required this.hintText,
    required this.icon,
    this.controller,
    this.obscureText,
  });

  final bool visible;
  final Function()? onTap;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColor().white),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: controller,
          cursorColor: AppColor().white,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: onTap,
                icon: Icon(icon),
                color: AppColor().white.withOpacity(0.7),
              ),
              hintText: hintText,
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

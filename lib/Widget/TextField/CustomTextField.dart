// ignore_for_file: file_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Util/Colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.visible,
    this.onTap,
    this.hintText,
    this.icon,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.inputFormatters,
    this.maxlength,
    this.textAlign,
  });

  final bool? visible;
  final Function()? onTap;
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxlength;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColor().white),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          textAlign: textAlign ?? TextAlign.start,
          maxLength: maxlength,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          cursorColor: AppColor().white,
          obscureText: obscureText ?? false,
          inputFormatters:
              inputFormatters ?? [], // Sadece sayılar ve en fazla 2 karakter
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: onTap,
                icon: Icon(icon),
                color: AppColor().white.withOpacity(0.7),
              ),
              hintText: hintText ?? "",
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

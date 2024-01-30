import 'package:flutter/material.dart';

import '../../Util/Colors.dart';

class CustomTextField_Edit extends StatelessWidget {
  const CustomTextField_Edit({
    super.key,
    required this.hintText,
    this.obscureText,
    this.controller,
    this.onTap,
  });

  final String hintText;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextField(
          controller: controller,
          onTap: onTap,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              focusColor: AppColor().blue,
              hintText: hintText,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor().blue.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(20)),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ))),
    );
  }
}

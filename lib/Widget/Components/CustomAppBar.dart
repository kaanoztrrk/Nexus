// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {super.key, required this.title, this.leading, this.action});

  final String title;
  final Widget? leading;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined)),
      title: Text(title,
          style: customGoogleTextStyle().copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 24,
          )),
      actions: action,
    );
  }
}

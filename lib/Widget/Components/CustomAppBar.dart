// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {super.key,
      this.title,
      this.leading,
      this.action,
      this.leadingImplyAuto,
      this.leadingfunc});

  final String? title;
  final Widget? leading;
  final List<Widget>? action;
  final bool? leadingImplyAuto;
  final Function()? leadingfunc;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leadingImplyAuto ?? false,
      leading: leading,
      title: Text(title ?? "",
          style: customGoogleTextStyle().copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 24,
          )),
      actions: action,
    );
  }
}

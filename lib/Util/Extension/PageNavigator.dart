// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future pageNavigator(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}

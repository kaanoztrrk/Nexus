// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';

class SnackBarService {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor().white,
        content: Text(
          message,
          style: customGoogleTextStyle(color: AppColor().bgColor, size: 14),
        ),
        duration: const Duration(seconds: 3), // Snackbar'ın görüntüleme süresi
      ),
    );
  }
}

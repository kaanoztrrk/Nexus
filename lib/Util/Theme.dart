import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';

class AppThemeClass {
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor().bgColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor().bgColor,
        elevation: 0,
        centerTitle: true,
      ));
  static ThemeData ligthTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
  );
}

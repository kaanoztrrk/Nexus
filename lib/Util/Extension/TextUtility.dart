// ignore_for_file: file_names, constant_identifier_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customGoogleTextStyle({Color? color}) {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: color,
      fontSize: 20.0, // Yazı tipi boyutu, ihtiyaca göre değiştirilebilir.
      fontWeight: FontWeight
          .w400, // Yazı tipi kalınlığı, ihtiyaca göre değiştirilebilir.
    ),
  );
}

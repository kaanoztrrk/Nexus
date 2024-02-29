// ignore_for_file: file_names, depend_on_referenced_packages, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

import '../Pages/Home.dart';

class UserDataStorage {
  static Future<void> saveUserData({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String age,
    required String gender,
    File? image,
    required BuildContext context,
  }) async {
    try {
      // Firestore kullanıcı koleksiyonuna yeni bir belge ekleyin
      DocumentReference userRef =
          await FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'gender': gender,
      });
      print('User added with ID: ${userRef.id}');

      // Kullanıcının kimliğini yerel depoya kaydet

      SharedPreferences.getInstance()
          .then((value) => value.setString("userId", userRef.id));

      // Anasayfaya yönlendir
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(userID: userRef.id),
        ),
      );
    } catch (error) {
      print('Failed to add user: $error');
      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add user. Please try again.'),
        ),
      );
    }
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

import '../Home.dart';

class UserDataStorage {
  static Future<void> saveUserData({
    required String email,
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
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'gender': gender,
      });
      print('User added with ID: ${userRef.id}');

      // Eğer kullanıcı bir resim seçmişse, Firebase Storage'a yükle
      if (image != null) {
        // Resmi Firebase Storage'a yükle
        String fileName = path.basename(image.path);
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/${userRef.id}/$fileName');
        await storageRef.putFile(image);

        // Resmin URL'sini Firestore belgesine ekle
        String imageUrl = await storageRef.getDownloadURL();
        await userRef.update({'imageUrl': imageUrl});

        // Resmin URL'sini yerel depoya kaydetme (isteğe bağlı)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profileImage', imageUrl);
      }

      // Kullanıcının kimliğini yerel depoya kaydet
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userRef.id);

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
        SnackBar(
          content: Text('Failed to add user. Please try again.'),
        ),
      );
    }
  }
}

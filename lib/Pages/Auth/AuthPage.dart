// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home.dart';
import 'AuthPages/LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserIdFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          // Kullanıcı oturum açmışsa Home sayfasına yönlendir
          return Home(userID: snapshot.data!);
        } else {
          // Kullanıcı oturum açmamışsa oturum açma sayfasına yönlendir
          return const LoginPage();
        }
      },
    );
  }

  Future<String?> _getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    print('User ID: $userId'); // UserID'yi print et
    return userId;
  }
}

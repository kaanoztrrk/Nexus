import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home.dart';
import 'AuthPages/LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserIdFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
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
          return LoginPage();
        }
      },
    );
  }

  Future<String?> _getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}

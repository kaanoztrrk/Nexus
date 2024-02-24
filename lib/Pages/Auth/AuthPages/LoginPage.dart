import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Home.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Widget/Button/ClassicButton.dart';
import 'package:nexus/Widget/CustomTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Util/Extension/PageNavigator.dart';
import '../../../Util/Extension/Size.dart';
import '../../../Widget/Components/NexusShower.dart';
import '../Components/SocialLoginButton.dart';

import 'SingUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void checkPassword() => setState(() => obscureText = !obscureText);

  Future<void> _signIn() async {
    try {
      // Kullanıcının verilerini Firestore'dan kontrol et
      QuerySnapshot userSnapshots = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailController.text)
          .where('password', isEqualTo: _passwordController.text)
          .get();

      // Kullanıcı bulunamadıysa veya şifre eşleşmiyorsa
      if (userSnapshots.docs.isEmpty) {
        throw Exception("User not found or incorrect password.");
      }

      // İlk dökümanı al, çünkü eğer birden fazla eşleşme varsa, ilkini almak yeterli olacaktır
      DocumentSnapshot userSnapshot = userSnapshots.docs.first;

      SharedPreferences.getInstance()
          .then((value) => value.setString("userId", userSnapshot.id));

      // Giriş başarılı, yapılacak işlemler
      pageNavigator(context, Home(userID: userSnapshot.id));
    } catch (e) {
      print("Giriş hatası: ${e.toString()}");
      // Giriş başarısız, kullanıcıya hata mesajı gösterilebilir
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your email or password is incorrect")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: displayHeight(context) * 0.1,
              horizontal: displayWidth(context) * 0.05),
          child: Column(
            children: [
              SizedBox(
                  width: displayWidth(context),
                  height: displayHeight(context) * 0.3,
                  child: const NexusShower()),
              SizedBox(
                width: displayWidth(context),
                height: displayHeight(context) * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      visible: true,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      visible: true,
                      hintText: "Password",
                      icon: obscureText == true
                          ? Icons.password
                          : Icons.remove_red_eye,
                      onTap: checkPassword,
                      obscureText: obscureText,
                    ),
                    _functionText(context, Alignment.topRight,
                        "Forget Password ?", "", 0.7),
                    CustomClassicButton(title: "Login", onTap: _signIn),
                    _functionText(
                        context,
                        Alignment.topCenter,
                        "Don't have an account? ",
                        " Register!",
                        1,
                        () => pageNavigator(context, const SignUpPage())),
                    const SocialMediaLogIn()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _functionText(BuildContext context, AlignmentGeometry alignment,
      String title, secText, double opacity,
      [Function()? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding: EdgeInsets.symmetric(vertical: displayHeight(context) * 0.02),
        child: Text.rich(
          TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 14, color: AppColor().white.withOpacity(opacity)),
              children: [
                TextSpan(
                    text: secText,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor().white)),
              ]),
        ),
      ),
    );
  }
}

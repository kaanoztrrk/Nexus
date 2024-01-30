// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Pages/Auth/AuthPage.dart';
import 'package:nexus/Pages/Home.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import 'package:nexus/Widget/TextField/CustomTextField.dart';

import '../../../Util/Extension/PageNavigator.dart';

import '../../../Util/Extension/Size.dart';
import '../../../Util/Extension/TextUtility.dart';
import '../../../Widget/Button/ClassicButton.dart';
import '../../../Widget/Components/NexusShower.dart';
import '../Components/SocialLoginButton.dart';
import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorText = '';

  void checkPassword() => setState(() => obscureText = !obscureText);

  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Kayıt başarılı, yapılacak işlemler
      pageNavigator(context, const Home());
    } catch (e) {
      print("Kayıt hatası: $e");
      setState(() {
        _errorText = 'Kayıt hatası: $e';
      });
      // Kayıt başarısız, kullanıcıya hata mesajı gösterilebilir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: displayHeight(context) * 0.1,
              horizontal: displayWidth(context) * 0.05),
          child: Column(
            children: [
              const Hero(tag: 'nexus_shower', child: NexusShower()),
              SizedBox(
                //  color: Colors.amber,
                width: displayWidth(context),
                height: displayHeight(context) * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextField(
                      visible: true,
                      controller: _emailController,
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
                    CustomClassicButton(title: "Sign In", onTap: _signUp),
                    _functionText(
                        context,
                        Alignment.topCenter,
                        "Do you have an account ? Login !",
                        1,
                        () => Navigator.pop(context)),
                    const SocialMediaLogIn()
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _functionText(BuildContext context, AlignmentGeometry alignment,
      String title, double opacity,
      [Function()? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding: EdgeInsets.symmetric(vertical: displayHeight(context) * 0.02),
        child: Text(
          title,
          style: customGoogleTextStyle().copyWith(
              fontSize: 14, color: AppColor().white.withOpacity(opacity)),
        ),
      ),
    );
  }
}

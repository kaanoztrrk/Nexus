// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import '../Components/SocialLoginButton.dart';
import 'package:nexus/Widget/TextField/CustomTextField.dart';

import '../../../Util/Extension/PageNavigator.dart';
import '../../../Util/Extension/Size.dart';
import '../../../Util/Extension/TextUtility.dart';
import '../../../Widget/Button/ClassicButton.dart';
import '../../../Widget/Components/NexusShower.dart';

import 'SingUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //String _errorText = '';

  void checkPassword() => setState(() => obscureText = !obscureText);

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Giriş başarılı, yapılacak işlemler
    } catch (e) {
      print("Giriş hatası: ${e.toString()}");
      // Giriş başarısız, kullanıcıya hata mesajı gösterilebilir
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Your email or password is incorrect")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                  //  color: Colors.amber,
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
                          "Forget Password ?", 0.7),
                      CustomClassicButton(title: "Login", onTap: _signIn),
                      _functionText(
                          context,
                          Alignment.topCenter,
                          "Don't have an account? Register!",
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

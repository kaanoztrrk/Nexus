// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Pages/Auth/AuthPages/LoginPage.dart';
import 'package:nexus/Pages/Auth/AuthPages/OTPEmail.dart';
import 'package:nexus/Service/ScaffoldMessage.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Widget/CustomTextField.dart';
import 'package:email_otp/email_otp.dart';

import '../../../Util/Extension/Size.dart';
import '../../../Util/Extension/TextUtility.dart';
import '../../../Widget/Button/ClassicButton.dart';
import '../../../Widget/Components/NexusShower.dart';
import '../Components/SocialLoginButton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  void checkPassword() => setState(() => obscureText = !obscureText);
  void _signUpWithEmail(String email, String password) async {
    try {
      // E-posta adresinin veritabanında bulunup bulunmadığını kontrol etme
      bool emailExists = await checkIfEmailExists(email);
      if (emailExists) {
        // Eğer e-posta adresi veritabanında bulunuyorsa, kullanıcıya uygun bir mesaj göster
        SnackBarService.showSnackBar(
            context, "Email already exists. Please sign in.");
        pageNavigator(context, const LoginPage());
      } else {
        // Eğer e-posta adresi veritabanında bulunmuyorsa, OTP gönderme işlemine geç
        myAuth.setConfig(
          appEmail: "kaanoztrrk411@gmail.com",
          appName: "N.E.X.U.S",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly,
        );
        myAuth.setTheme(theme: "v3");
        await myAuth.sendOTP();
        pageNavigator(
          context,
          OTPScreen(
            email: email,
            password: password,
            myAuth: myAuth,
          ),
        );
      }
    } catch (e) {
      // E-posta kontrolü sırasında bir hata oluşursa kullanıcıya bilgi verme
      SnackBarService.showSnackBar(
          context, "Email check operation failed, please try again.");
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      // Firestore'da 'users' koleksiyonunu sorgula
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      // Sorgu sonucunda eşleşen belge varsa, e-posta adresi mevcuttur
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Sorgu sırasında bir hata oluşursa false döndür
      print('Error checking email existence: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
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
                        keyboardType: TextInputType.emailAddress,
                        visible: true,
                        controller: _emailController,
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        visible: true,
                        hintText: "Password",
                        icon: obscureText == true
                            ? Icons.password
                            : Icons.remove_red_eye,
                        onTap: checkPassword,
                        obscureText: obscureText,
                      ),
                      CustomClassicButton(
                        title: "Sign In",
                        onTap: () => _signUpWithEmail(
                            _emailController.text, _passwordController.text),
                      ),
                      _functionText(
                          context,
                          Alignment.topCenter,
                          "Do you have an account? ",
                          " Login!",
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
              style: customGoogleTextStyle().copyWith(
                  fontSize: 14, color: AppColor().white.withOpacity(opacity)),
              children: [
                TextSpan(
                    text: secText,
                    style: customGoogleTextStyle().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor().white)),
              ]),
        ),
      ),
    );
  }
}

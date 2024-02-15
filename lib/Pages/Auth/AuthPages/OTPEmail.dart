// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus/Pages/Auth/AuthPages/UsersStartProfile.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';
import 'package:nexus/Widget/Button/ClassicButton.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.myAuth});
  final String email;
  final String password;
  final EmailOTP myAuth;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  final TextEditingController t3 = TextEditingController();
  final TextEditingController t4 = TextEditingController();
  bool _isWrongOTP = false;

  void _verifyOTP(String t1, String t2, String t3, String t4) async {
    // Kullanıcının girdiği dört haneli OTP'yi oluştur
    var inputOTP = "$t1$t2$t3$t4";

    // OTP doğrulamasını yap
    bool isVerified = await widget.myAuth.verifyOTP(otp: inputOTP);

    if (isVerified) {
      // Doğrulama başarılıysa
      pageNavigator(
          context,
          UserStartProfilePage(
            email: widget.email,
            password: widget.password,
          ));
    } else {
      // Doğrulama başarısızsa
      setState(() {
        _isWrongOTP = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                  text: "Verification code\n",
                  style: customGoogleTextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "We have sent the code verfication to\n",
                        style: customGoogleTextStyle(
                            fontWeight: FontWeight.w300, size: 16)),
                  ]),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text.rich(TextSpan(
                  text: widget.email,
                  style: customGoogleTextStyle(size: 16),
                  children: [
                    TextSpan(
                        text: "  Change Email ?",
                        style: customGoogleTextStyle(
                            size: 14, color: AppColor().blue))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Form(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _otpTextField(context, t1),
                  _otpTextField(context, t2),
                  _otpTextField(context, t3),
                  _otpTextField(context, t4),
                ],
              )),
            ),
            const Spacer(),
            CustomClassicButton(
              title: "Continue",
              onTap: () => _verifyOTP(t1.text, t2.text, t3.text, t4.text),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _otpTextField(
      BuildContext context, TextEditingController controller) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          hintText: "0",
          fillColor: AppColor().crdColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: _isWrongOTP ? Colors.red : AppColor().crdColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: _isWrongOTP ? Colors.red : AppColor().white, width: 2),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor().crdColor)),
        ),
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }
}

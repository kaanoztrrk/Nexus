import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';

class LegalandPolicies extends StatelessWidget {
  const LegalandPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const CustomAppbar(title: "Legal and Policies"),
        ),
        body: Container(
          alignment: Alignment.topRight,
          width: displayWidth(context),
          height: displayHeight(context),
          padding: EdgeInsets.all(20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Privacy Policy\n"),
                  _description(
                      "Version Date: [Version Date]\n\nWelcome! Thank you for using Nexus Voice Assistant. This privacy policy explains the privacy practices and data collection policies of our application.\n"),
                  _title("1. Collected Data\n"),
                  _description(
                      "Nexus Voice Assistant may collect certain data to provide essential functionality and enhance the user experience. This may include speech data, language preferences, and information related to the performance of the application.\n"),
                  _title("2. Privacy Policy Updates\n"),
                  _description(
                      "We may update our privacy policy from time to time. When there is an update, we will announce the current information within the application or on the app store page to provide you with the latest details.\n"),
                  _title("3. Cookies\n"),
                  _description(
                      "The Nexus Voice Assistant application may use cookies to improve the user experience and for analytics purposes. You can manage cookies through the application settings to specify your preferences.\n"),
                  _title("4. Third-Party Services\n"),
                  _description(
                      "Our application may integrate with certain third-party services. Information regarding the privacy policies of these services can be found on the respective service provider's website.\n"),
                  _title("5. Security\n"),
                  _description(
                      "The security of user data is important to us. Our application takes security measures to protect your data.\n"),
                  _title("6. User Rights\n"),
                  _description(
                      "Users of Nexus Voice Assistant have the right to inquire about, correct, or request the deletion of data we have collected. Please contact us to exercise these rights.\n\nBy accepting this privacy policy, you agree to comply with these policy terms while using the Nexus Voice Assistant application.\n"),
                  _description(
                      "\nIf you have any questions or feedback, feel free to contact us.\n"),
                  _description("Thank you!\n"),
                  _title("Theviacoder\n")
                ],
              )
            ],
          ),
        ));
  }

  Text _title(String title) {
    return Text(
      title,
      style: customGoogleTextStyle().copyWith(
          fontWeight: FontWeight.w500, fontSize: 20, color: AppColor().white),
    );
  }

  Text _description(String desciption) {
    return Text(
      desciption,
      style: customGoogleTextStyle().copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: AppColor().white.withOpacity(0.7)),
    );
  }
}

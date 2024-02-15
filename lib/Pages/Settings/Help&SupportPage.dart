// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Util/Colors.dart';
import '../../Util/Extension/Size.dart';
import '../../Util/Extension/TextUtility.dart';
import '../../Widget/Components/CustomAppBar.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

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
          padding: const EdgeInsets.all(20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Help & Support\n"),
                  _description(
                      "Welcome! If you encounter any issues or need assistance while using Nexus Voice Assistant, we are here to help. Below, you will find resources to resolve common problems or access additional information.\n"),
                  _title("Frequently Asked Questions (FAQ)\n"),
                  _description(
                      "We have a Frequently Asked Questions section where you can find answers to most of your questions. You can access the FAQ section within the [app name] application or visit [website link].\n"),
                  _title("Contact\n"),
                  _description(
                      "If you are unable to find solutions to your questions or issues, you can reach out to us directly. Contact us by filling out our contact form or sending an email to [support email address].\n"),
                  _title("Feedback\n"),
                  _description(
                      "Your feedback is valuable and helps us improve our application. If you have suggestions, improvements, or new ideas, please let us know. You can submit your feedback through our [feedback form] link.\n"),
                  _title("Social Media\n"),
                  _description(
                      "Stay updated on the latest developments and announcements by following us on [social media platforms]. Engage with us and be part of the community.\n"),
                  _description(
                      "Remember, we are here to assist you. If you have any questions or concerns, please don't hesitate to reach out. Thank you!\n"),
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

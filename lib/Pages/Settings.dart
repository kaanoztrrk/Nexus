// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Controller/AppsListController.dart';
import 'package:nexus/Pages/Auth/AuthPage.dart';
import 'package:nexus/Pages/Auth/AuthPages/LoginPage.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';

import 'Settings/ProfileEdit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppsListController appsListController = AppsListController();

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const CustomAppbar(title: "Setting")),
      body: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.05),
        child: Column(
          children: [
            _profile(context),
            _general(context, appsListController),
            _preferences(context, appsListController)
          ],
        ),
      ),
    );
  }

  Widget _profile(BuildContext context) {
    return InkWell(
      onTap: () => pageNavigator(context, ProfileEditPage()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: displayWidth(context),
        height: displayHeight(context) * 0.1,
        decoration: BoxDecoration(
            color: AppColor().crdColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const CustomAvatar(size: 0.150),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Kaan Öztürk",
                      style: customGoogleTextStyle()
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                  Text(
                    "kaanoztrrk411@gmail.com",
                    style: customGoogleTextStyle().copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColor().white.withOpacity(0.7)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _general(BuildContext context, AppsListController listController) {
    final Color textColor = AppColor().white.withOpacity(0.7);
    final double iconSize = 0.075;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: displayWidth(context),
        height: displayHeight(context) * 0.425,
        decoration: BoxDecoration(
            color: AppColor().crdColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("General",
                  style: customGoogleTextStyle()
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listController.settingsGeneralList.length,
                itemBuilder: (context, index) {
                  var item =
                      listController.getSettingsGeneralList(context)[index];
                  return InkWell(
                    onTap: item[2],
                    child: ListTile(
                        leading: Image(
                          width: displayWidth(context) * iconSize,
                          image: item[0],
                          color: textColor,
                        ),
                        title: Text(
                          item[1],
                          style: customGoogleTextStyle().copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: textColor)),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _preferences(BuildContext context, AppsListController listController) {
    final Color textColor = AppColor().white.withOpacity(0.7);
    final double iconSize = 0.075;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<void> _signOut() async {
      await _auth.signOut();
      pageNavigator(context, AuthPage());
    }

    return Container(
        width: displayWidth(context),
        height: displayHeight(context) * 0.275,
        decoration: BoxDecoration(
            color: AppColor().crdColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ListTile(
              title: Text("Preferences",
                  style: customGoogleTextStyle()
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listController.settingsPreferencesList.length,
                itemBuilder: (context, index) {
                  var item =
                      listController.getSettingsPreferencesList(context)[index];
                  return InkWell(
                    onTap: item[2],
                    child: ListTile(
                        leading: Image(
                          width: displayWidth(context) * iconSize,
                          image: item[0],
                          color: textColor,
                        ),
                        title: Text(
                          item[1],
                          style: customGoogleTextStyle().copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: textColor)),
                  );
                },
              ),
            ),
            ListTile(
              onTap: _signOut,
              leading: Image(
                width: displayWidth(context) * 0.075,
                image: IconImageEnum.logout.toPath,
                color: Colors.red,
              ),
              title: Text(
                "Logout",
                style: customGoogleTextStyle().copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ],
        ));
  }
}

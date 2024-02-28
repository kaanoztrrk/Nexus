// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:nexus/Controller/AppsListController.dart';
import 'package:nexus/Models/Users.dart';
import 'package:nexus/Pages/Auth/AuthPage.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';
import 'package:nexus/Widget/Components/Avatar.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Settings/ProfileEdit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.user, this.userID});
  final UserProfile? user;
  final String? userID;

  @override
  Widget build(BuildContext context) {
    AppsListController listController = AppsListController();

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomAppbar(
            title: "Setting",
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back)),
          )),
      body: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.05),
        child: Column(
          children: [
            _profile(context),
            Expanded(
                child: Container(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listController.settingsGeneralList.length,
                itemBuilder: (context, index) {
                  final Color textColor = AppColor().white.withOpacity(0.7);
                  const double iconSize = 0.075;
                  var item =
                      listController.getSettingsGeneralList(context)[index];
                  return InkWell(
                    onTap: item[2],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: AppColor().crdColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
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
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _profile(BuildContext context) {
    return InkWell(
      onTap: () =>
          pageNavigator(context, ProfileEditPage(user: user, userID: userID)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: displayWidth(context),
        height: displayHeight(context) * 0.1,
        decoration: BoxDecoration(
            color: AppColor().crdColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${user?.firstName} ${user?.lastName}",
                      style: customGoogleTextStyle()
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                  Text(
                    user?.email ?? "",
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
}

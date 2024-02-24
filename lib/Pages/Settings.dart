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
    AppsListController appsListController = AppsListController();

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
            _general(context, appsListController),
            _preferences(context, appsListController),
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
            const CustomAvatar(size: 0.150),
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

  Widget _general(BuildContext context, AppsListController listController) {
    final Color textColor = AppColor().white.withOpacity(0.7);
    const double iconSize = 0.075;
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
    const double iconSize = 0.075;

    Future<void> signOut(BuildContext context) async {
      try {
        // SharedPreferences'ten userId'yi sil
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('userId');

        // Çıkış yaptıktan sonra AuthPage'e yönlendirme
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AuthPage()));
      } catch (error) {
        print('Error signing out: $error');
        // Hata durumunda kullanıcıya bilgi verebilirsiniz
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Sign Out Error'),
              content: const Text(
                  'An error occurred while signing out. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
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
              onTap: () => signOut(context),
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
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Pages/Home.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/Button/AppsButton.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';

import '../Controller/AppsListController.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key, required this.userID});

  final String? userID;

  @override
  Widget build(BuildContext context) {
    AppsListController appsListController = AppsListController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppbar(
          title: "Apps",
          leading: IconButton(
              onPressed: () =>
                  pageNavigator(context, Home(userID: userID ?? "")),
              icon: const Icon(Icons.arrow_back)),
        ),
      ),
      body: Expanded(
          child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: appsListController.getAppList(context).length,
        itemBuilder: (context, index) {
          var item = appsListController.getAppList(context)[index];
          return AppsButton(
            title: item[1],
            onTap: item[2],
            child: Image(
              image: item[0],
              color: AppColor().white.withOpacity(0.2),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: displayHeight(context) * 0.02);
        },
      )),
    );
  }
}

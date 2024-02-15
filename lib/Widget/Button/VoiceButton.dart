// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Pages/Apps/Apps.dart';
import 'package:nexus/Pages/Settings/Settings.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';
import 'package:nexus/Util/Extension/PageNavigator.dart';
import 'package:nexus/Widget/Button/OutlineBorderButton.dart';

import '../../Util/Colors.dart';
import '../../Util/Extension/Size.dart';

class VoiceButton extends StatelessWidget {
  const VoiceButton({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.05) +
          EdgeInsets.only(bottom: displayHeight(context) * 0.025),
      height: displayHeight(context) * 0.125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          menusIconButtonWidget(
              context,
              IconImageEnum.home.toPath,
              () => pageNavigator(context, const AppsPage()),
              0.5,
              0.175,
              0.075),
          menusIconButtonWidget(
              context, IconImageEnum.mic.toPath, onTap!, 1, 0.25, 0.1),
          menusIconButtonWidget(
              context,
              IconImageEnum.settings.toPath,
              () => pageNavigator(context, const SettingsPage()),
              0.5,
              0.175,
              0.075),
        ],
      ),
    );
  }

  Widget menusIconButtonWidget(
    BuildContext context,
    ImageProvider<Object> image,
    Function() page,
    double colorRadius,
    double size,
    double iconSize,
  ) {
    return OutlineButton(
      size: displayWidth(context) * size,
      strokeWidth: 2.5,
      radius: 100,
      gradient: LinearGradient(colors: <Color>[
        AppColor().pink.withOpacity(colorRadius),
        AppColor().blue.withOpacity(colorRadius),
      ]),
      onPressed: page,
      child: Image(width: displayWidth(context) * iconSize, image: image),
    );
  }
}

/*

 GestureDetector(
      onTap: onTap,
      child: Container(
        width: displayWidth(context) * 0.2,
        height: 100,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor().blue,
          boxShadow: [
            BoxShadow(
              color: AppColor().blue.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: const Image(
          image: AssetImage("assets/icon/voice.png"),
        ),
      ),
    );
 */

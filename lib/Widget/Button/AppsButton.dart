import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Util/Extension/TextUtility.dart';

import 'OutlineBorderButton.dart';

class AppsButton extends StatelessWidget {
  const AppsButton(
      {super.key, required this.title, required this.child, this.onTap});

  final String title;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const double size = 0.005;
    return OutlineButton(
        width: displayWidth(context),
        height: displayHeight(context) * 0.15,
        strokeWidth: 2.5,
        radius: 30,
        gradient: LinearGradient(
          colors: <Color>[
            AppColor().pink.withOpacity(0.5),
            AppColor().blue.withOpacity(0.5),
          ],
        ),
        onPressed: onTap,
        child: Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: AppColor().crdColor,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: customGoogleTextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Transform.rotate(angle: 0.1, child: child),
            ],
          ),
        ));
  }
}

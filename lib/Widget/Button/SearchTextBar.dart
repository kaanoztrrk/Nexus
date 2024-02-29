import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/Size.dart';
import 'package:nexus/Widget/CustomTextField.dart';

import '../../Util/Extension/PageNavigator.dart';
import 'OutlineBorderButton.dart';

class SearchTextBar extends StatelessWidget {
  const SearchTextBar(
      {super.key, required this.controller, this.sendOnTap, this.pictureOnTap});

  final TextEditingController controller;
  final Function()? sendOnTap;
  final Function()? pictureOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: displayWidth(context),
      height: displayHeight(context) * 0.1,
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: CustomTextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              hintText: "Search",
              suffixIcon: IconButton(
                  onPressed: pictureOnTap,
                  icon: Icon(
                    Icons.image_search,
                    color: AppColor().white,
                  )),
            ),
          )),
          SizedBox(width: 10),
          OutlineButton(
            size: displayWidth(context) * 0.15,
            strokeWidth: 2.5,
            radius: 100,
            gradient: LinearGradient(colors: <Color>[
              AppColor().pink.withOpacity(0.5),
              AppColor().blue.withOpacity(0.5),
            ]),
            onPressed: sendOnTap,
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

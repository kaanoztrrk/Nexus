import 'package:flutter/material.dart';

import '../../Util/Colors.dart';

class GenderSelector extends StatefulWidget {
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ratioButton("Man",
            currentIndex == 0 ? AppColor().blue : AppColor().crdColor, 0),
        ratioButton("Women",
            currentIndex == 1 ? AppColor().pink : AppColor().crdColor, 1),
      ],
    );
  }

  Widget ratioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: color,
          ),
          onPressed: () {
            return changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
              color: AppColor().white,
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';

class GenderSelector extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String defaultValue;

  const GenderSelector({Key? key, this.onChanged, this.defaultValue = "Man"})
      : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.defaultValue.toLowerCase() == "man" ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ratioButton(
              "Man", currentIndex == 1 ? Colors.blue : Colors.grey, 1),
        ),
        Container(
          width: 10,
          height: 10,
          child: ratioButton("", AppColor().white, 0),
          decoration:
              BoxDecoration(color: AppColor().white, shape: BoxShape.circle),
        ),
        Expanded(
          child: ratioButton(
              "Women", currentIndex == 2 ? Colors.pink : Colors.grey, 2),
        ),
      ],
    );
  }

  Widget ratioButton(String value, Color color, int index) {
    return Container(
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
          changeIndex(index);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        child: Text(
          value,
          style: TextStyle(
            color: Colors.white,
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

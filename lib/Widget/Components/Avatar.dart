import 'package:flutter/material.dart';

import '../../Util/Colors.dart';
import '../../Util/Extension/Size.dart';
import '../Button/OutlineBorderButton.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, this.func, required this.size, this.image});

  final Function()? func;
  final Widget? image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      size: displayWidth(context) * size,
      strokeWidth: 2.5,
      radius: 100,
      gradient: LinearGradient(colors: <Color>[
        AppColor().pink.withOpacity(0.5),
        AppColor().blue.withOpacity(0.5),
      ]),
      onPressed: func,
      child: ClipRRect(borderRadius: BorderRadius.circular(50), child: image),
    );
  }
}

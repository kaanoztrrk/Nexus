import 'package:flutter/material.dart';

import '../../Util/Colors.dart';
import '../../Util/Extension/ImageExtension.dart';
import '../../Util/Extension/TextUtility.dart';

class NexusShower extends StatelessWidget {
  const NexusShower({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ColorFiltered(
            colorFilter: ColorFilter.mode(
                AppColor().bgColor.withOpacity(0.2), BlendMode.darken),
            child: Image(image: NexusBgImageEnum.nexus_10.toPath)),
        Text(
          "Nexus",
          style: customGoogleTextStyle(color: AppColor().white)
              .copyWith(fontSize: 32, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

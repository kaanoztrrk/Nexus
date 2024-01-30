import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';

class SocialMediaLogIn extends StatelessWidget {
  const SocialMediaLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          _socialMediaItem(
              context, IconImageEnum.social_google.toPath, "Google"),
          _socialMediaItem(context, IconImageEnum.social_apple.toPath, "Apple"),
        ],
      ),
    );
  }

  Expanded _socialMediaItem(
      BuildContext context, ImageProvider<Object> image, String title) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
            border:
                Border.all(width: 2, color: AppColor().white.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              color: AppColor().white,
              width: 30,
              image: image,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: VerticalDivider(
                width: 1.5,
                thickness: 1.5,
                color: AppColor().crdColor.withOpacity(0.5),
              ),
            ),
            Text(
              "With $title",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

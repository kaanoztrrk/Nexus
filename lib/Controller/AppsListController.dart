// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Pages/Apps/Apps.dart';
import 'package:nexus/Pages/Settings/Help&SupportPage.dart';
import 'package:nexus/Pages/Settings/LegalandPolicies.dart';
import 'package:nexus/Pages/Settings/SoundsandTonePage.dart';
import 'package:nexus/Pages/Settings/ThemePage.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';
import '../Util/Extension/PageNavigator.dart';

class AppsListController {
  List appsList = [];
  List settingsGeneralList = [
    [
      IconImageEnum.voice.toPath,
      "Sound and Tone",
      SoundandTonePage(),
    ],
    [
      IconImageEnum.theme.toPath,
      "Theme",
      const ThemesPage(),
    ],
    [
      IconImageEnum.skills.toPath,
      "Skills",
      const AppsPage(),
    ],
    [
      IconImageEnum.speechReturn.toPath,
      "Speech Return",
      const AppsPage(),
    ],
    [
      IconImageEnum.language.toPath,
      "Language",
      const AppsPage(),
    ],
  ];
  List settingsPreferencesList = [
    [
      IconImageEnum.shield.toPath,
      "Legal and Policies",
      const LegalandPolicies()
    ],
    [
      IconImageEnum.help.toPath,
      "Help & Support",
      const HelpSupportPage(),
    ],
  ];

  List bgList = [
    "assets/nexus_bg/nexus_1.gif",
    "assets/nexus_bg/nexus_2.gif",
    "assets/nexus_bg/nexus_3.gif",
    "assets/nexus_bg/nexus_4.gif",
    "assets/nexus_bg/nexus_5.gif",
    "assets/nexus_bg/nexus_6.gif",
    "assets/nexus_bg/nexus_7.gif",
    "assets/nexus_bg/nexus_8.gif",
    "assets/nexus_bg/nexus_9.gif",
    "assets/nexus_bg/nexus_10.gif",
  ];

  List getAppList(BuildContext context) {
    return appsList.map((item) {
      if (item is List) {
        return [item[0], () => pageNavigator(context, item[2])];
      } else {
        return item;
      }
    }).toList();
  }

  List getSettingsGeneralList(BuildContext context) {
    return settingsGeneralList.map((item) {
      if (item is List) {
        return [item[0], item[1], () => pageNavigator(context, item[2])];
      } else {
        return item;
      }
    }).toList();
  }

  List getSettingsPreferencesList(BuildContext context) {
    return settingsPreferencesList.map((item) {
      if (item is List) {
        return [item[0], item[1], () => pageNavigator(context, item[2])];
      } else {
        return item;
      }
    }).toList();
  }
}
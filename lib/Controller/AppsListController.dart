import 'package:flutter/material.dart';
import 'package:nexus/Pages/Apps.dart';
import 'package:nexus/Pages/Apps/NewTermsPage.dart';
import 'package:nexus/Pages/Apps/SearchPage/SearchPage.dart';
import 'package:nexus/Pages/Settings/Help&SupportPage.dart';
import 'package:nexus/Pages/Settings/LanguagePage.dart';
import 'package:nexus/Pages/Settings/LegalandPolicies.dart';
import 'package:nexus/Pages/Settings/SoundsandTonePage.dart';
import 'package:nexus/Pages/Settings/ThemePage.dart';
import 'package:nexus/Util/Extension/ImageExtension.dart';

import '../Pages/Apps/NotePage/NoteTodoPage.dart';
import '../Util/Extension/PageNavigator.dart';

class AppsListController {
  List appsList = [
    [IconImageEnum.language.toPath, "Translate", LanguageSelectionPage()],
    [IconImageEnum.edit.toPath, "Note", NoteTodoPage()],
    [IconImageEnum.search.toPath, "Search", SearchPage()],
    [IconImageEnum.voice.toPath, "New Term", AddTermPage()],
    [IconImageEnum.dictionary.toPath, "Dictionary", AddTermPage()],
  ];

  List settingsGeneralList = [
    [IconImageEnum.voice.toPath, "Sound and Tone", const SoundandTonePage()],
    [IconImageEnum.theme.toPath, "Theme", const ThemesPage()],
    [IconImageEnum.skills.toPath, "Skills", const ThemesPage()],
    [IconImageEnum.speechReturn.toPath, "Speech Return", const ThemesPage()],
    [IconImageEnum.language.toPath, "Language", LanguageSelectionPage()],
  ];

  List settingsPreferencesList = [
    [IconImageEnum.shield.toPath, "Legal and Policies", const Policies()],
    [IconImageEnum.help.toPath, "Help & Support", const HelpSupportPage()],
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
        return [item[0], item[1], () => pageNavigator(context, item[2])];
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

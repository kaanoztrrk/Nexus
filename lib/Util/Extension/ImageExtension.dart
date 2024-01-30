// ignore_for_file: file_names

import 'package:flutter/material.dart';

enum NexusBgImageEnum {
  nexus_1,
  nexus_2,
  nexus_3,
  nexus_4,
  nexus_5,
  nexus_6,
  nexus_7,
  nexus_8,
  nexus_9,
  nexus_10,
}

extension BgEnum on NexusBgImageEnum {
  AssetImage get toPath => AssetImage("assets/nexus_bg/$name.gif");
}

enum IconImageEnum {
  home,
  voice,
  mic,
  settings,
  equalizer,
  theme,
  skills,
  speechReturn,
  language,
  shield,
  help,
  logout,
  email,
  password,
  birthDay,
  gender,
  social_apple,
  social_google,
}

extension IconEnum on IconImageEnum {
  AssetImage get toPath => AssetImage("assets/icon/$name.png");
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nexus/Util/Colors.dart';

import '../../Service/ConnectivityService.dart';
import '../../Util/Extension/PageNavigator.dart';
import '../../Widget/Components/NexusShower.dart';
import 'AuthPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => pageNavigator(context, const EnternetCheckPage()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor().bgColor,
        body: const Center(
          child: Hero(tag: "nexus_shower", child: NexusShower()),
        ),
      ),
    );
  }
}

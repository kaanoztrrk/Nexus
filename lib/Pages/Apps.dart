// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Widget/Components/CustomAppBar.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppbar(title: "Apps"),
      ),
    );
  }
}

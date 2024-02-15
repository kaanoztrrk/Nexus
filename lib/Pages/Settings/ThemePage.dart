// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexus/Controller/AppsListController.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/Colors.dart';
import '../../Util/Extension/Size.dart';
import '../../Widget/Components/CustomAppBar.dart';
import '../../Widget/Button/OutlineBorderButton.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  int selectedImageIndex = 0;
  bool additionalButtonVisible = false;

  void _selectTheme() async {
    await savePreferences();
  }

  Future<void> _saveAndPop() async {
    await savePreferences();
  }

  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedImageIndex', selectedImageIndex);
  }

  void _restartApp() {
    Restart.restartApp(webOrigin: '_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppbar(
          title: "Themes",
          action: [
            if (additionalButtonVisible)
              IconButton(
                icon: Icon(
                  Icons.done,
                  color: additionalButtonVisible == true
                      ? AppColor().blue
                      : AppColor().grey,
                ),
                onPressed: () {
                  // İlave butona tıklandığında yapılacak işlemleri ekleyin.
                  _saveAndPop();
                  _restartApp();
                },
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Image(
                image:
                    AssetImage(AppsListController().bgList[selectedImageIndex]),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: displayHeight(context) * 0.05,
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  const double size = 0.175;
                  return OutlineButton(
                    size: displayWidth(context) * size,
                    strokeWidth: 2.5,
                    radius: 100,
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppColor().pink.withOpacity(0.5),
                        AppColor().blue.withOpacity(0.5),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                          width: displayWidth(context) * size - 10,
                          image:
                              AssetImage(AppsListController().bgList[index])),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedImageIndex = index;
                        additionalButtonVisible = true;
                        _selectTheme();
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemCount: AppsListController().bgList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

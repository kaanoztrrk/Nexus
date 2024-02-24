import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus/Pages/Auth/AuthPage.dart';
import 'package:nexus/Widget/Button/ClassicButton.dart';
import 'package:restart_app/restart_app.dart';
import '../Util/Colors.dart';
import '../Util/Extension/PageNavigator.dart';
import '../Util/Extension/Size.dart';
import '../Util/Extension/TextUtility.dart';

class EnternetCheckPage extends StatefulWidget {
  const EnternetCheckPage({super.key});

  @override
  State<EnternetCheckPage> createState() => _EnternetCheckPageState();
}

class _EnternetCheckPageState extends State<EnternetCheckPage> {
  var connectivityResult;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      connectivityResult = result;
    });
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      pageNavigator(context, AuthPage());
    }
  }

  void tryAgain() {
    setState(() {
      checkInternetConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (connectivityResult == ConnectivityResult.none) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.wifi_slash,
                        color: Colors.red,
                        size: displayWidth(context) * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: displayWidth(context) * 0.1),
                        child: Text(
                          "Woops!!",
                          style: customGoogleTextStyle(
                              size: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: displayWidth(context) * 0.2),
                        child: Text(
                          "No internet connection was found. Check your connection or try again.",
                          style: customGoogleTextStyle(size: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(displayWidth(context) * 0.075),
                    child: CustomClassicButton(
                        title: "Try Again",
                        onTap: () {
                          Restart.restartApp(webOrigin: '_');
                        }),
                  ))
            ],
          ),
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}

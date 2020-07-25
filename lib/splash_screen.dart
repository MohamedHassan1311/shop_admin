import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/Screens/admin/adminHome.dart';
import 'package:shoping/provider/loginstat.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Screens/login_screen.dart';
import 'constant.dart';

class SplashScrren extends StatefulWidget {
  static String id = "splash";
  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  getDate() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoged = prefs.getBool("isloged");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(getDate());
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    final loginStat = LoginStat();

    return SplashScreen(
      seconds: 4,
      image: Image.asset(
        "assets/images/icon.png",
        fit: BoxFit.cover,
      ),
      photoSize: 100,
      backgroundColor: Colors.purple,
      loaderColor: Colors.white,
      navigateAfterSeconds: isLoged == true ? AdminHomeScreen() : LoginScrren(),
    );
  }
}

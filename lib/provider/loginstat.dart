import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class LoginStat {
  saveData(isLoged) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("isloged", isLoged);
  }

  getDate() async {
    var prefs = await SharedPreferences.getInstance();

    isLoged = prefs.getBool("isloged");
  }
}

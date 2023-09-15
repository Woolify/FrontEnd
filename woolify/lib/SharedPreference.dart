import 'package:shared_preferences/shared_preferences.dart';

class mySharedPreference {
  static late SharedPreferences pref;

  static Future<SharedPreferences> initSharedPreference() async {
    pref = await SharedPreferences.getInstance();
    return pref;
  }
}

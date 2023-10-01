import 'package:woolify/SharedPreference.dart';

class ServerDetails {
  static String ip = "192.168.0.103";
  static String serverRoute = "http://$ip:8000";
  static Map<String, String> token = {
    "authorization": mySharedPreference.pref.getString('token')!
  };
}

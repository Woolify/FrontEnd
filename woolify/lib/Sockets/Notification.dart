import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotiFication {
  static FlutterLocalNotificationsPlugin fln =
      new FlutterLocalNotificationsPlugin();
  static Future initilize() async {
    var androidInit = AndroidInitializationSettings('mipmap/ic_launcher');
    // var IOSInit=IOSini
    var initSetting = new InitializationSettings(android: androidInit);
    await fln.initialize(initSetting);
  }

  static showNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    AndroidNotificationDetails adsf = AndroidNotificationDetails(
        'woolify_notification', 'woolify',
        playSound: true, importance: Importance.max, priority: Priority.high);

    var not = NotificationDetails(android: adsf);
    await fln.show(0, title, body, not);
  }
}

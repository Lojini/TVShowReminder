import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class NotificationManager {
  var flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initNotifications() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
//  scheduleReminder(String name,DateTime dateTime,int reminder) async {
//    int notificationId = await ScheduledNotifications.scheduleNotification(
//        new DateTime.now().add(new Duration(seconds: 5)).millisecondsSinceEpoch,
//        "Ticker text",
//        "Content title",
//        "Content");
//  }
  scheduleReminder(String name,DateTime dateTime,int reminder) async {
    String time = DateFormat.jm().format(dateTime).toString();
    var scheduledNotificationDateTime =
    dateTime.subtract(Duration(minutes: reminder));
    var scheduledNotificationDateTimeNow = DateTime.now().add(Duration(seconds: 10));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your show id',
      'show name',
      'time',
      sound: RawResourceAndroidNotificationSound('sound'),
    );
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        1234,
        name,
        'Today at $time',
        scheduledNotificationDateTimeNow,
        platformChannelSpecifics);
  }
  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
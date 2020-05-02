/*  This file contains the class for flutter local notification
    Schedules the notification in given time and date
    References:
       https://github.com/musabagab/MedicineReminder
 */
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
    // initialise the plugin.
    //app icon has been added as drawable resource in android
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  scheduleReminder(String name,DateTime dateTime,int reminder) async {
    //convert the time to 12 hours clock to show in the notification
    String time = DateFormat.jm().format(dateTime).toString();
    //subtract the reminder time from the show time
    var scheduledNotificationDateTime =
    dateTime.subtract(Duration(minutes: reminder));

    var androidPlatformSpecifics = AndroidNotificationDetails(
      'your show id',
      'show name',
      'time',
      ticker: 'Tv Show Reminder',
      //sound file has been added as raw in resource directory of android
      sound: RawResourceAndroidNotificationSound('sound'),
      importance: Importance.Max,
      priority: Priority.High
    );
    var iOSPlatformSpecifics =
    IOSNotificationDetails();
    var platformSpecifics = NotificationDetails(
        androidPlatformSpecifics, iOSPlatformSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        1234,
        '$name',
        'Today at $time',
        scheduledNotificationDateTime,
        platformSpecifics);
  }
  Future onSelectNotification(String payload) async {
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
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//Initializes the plugin for displaying notifications in-app
void initializeNotifications(BuildContext context) async {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('ic_alarm');

  //Needed for pre iOS 10 days.
  var initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) => showDialog(
                context: context,
                builder: (BuildContext context) => new CupertinoAlertDialog(
                  title: new Text(title),
                  content: new Text(body),
                  actions: [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: new Text('Ok'),
                    )
                  ],
                ),
              ));

  //Initialize all settings
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  //And pass them to the plugin
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

//Currently unused
Future onSelectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
}

//Displays the message
void displayNotification(String title, String message, DateTime time) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'demo_app_channel',
      'Demo App Channel',
      'Notification Channel for Demo App',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(
      0, title, message, time, platformChannelSpecifics);
}

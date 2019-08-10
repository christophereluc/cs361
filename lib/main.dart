import 'package:flutter/material.dart';
import 'package:cs361/themes.dart';
import 'package:cs361/login/login.dart';
import 'package:cs361/notifications/notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  initializeNotifications();

  runApp(MyApp());
}

void initializeNotifications() async {
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid = new AndroidInitializationSettings(
      'ic_alarm');

  var initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(
      initializationSettings, onSelectNotification: onSelectNotification);
}

Future onSelectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
}

Future onDidReceiveLocalNotification(int id, String title, String body,
    String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
}

void displayNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'demo_app_channel', 'Demo App Channel',
      'Notification Channel for Demo App',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS 361 Demo App',
      //Set material light theme for whole app -- no need to customize each individual widget/screen
      theme: kLightGalleryTheme,
      home: MyHomePage(title: "CS 361 Demo App"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Screen title
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  //Used for pushing new screens onto the activity stack
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginRoute()));
                },
                child: Text('Launch Login Screen')),
            RaisedButton(
                onPressed: () {
                  //Used for pushing new screens onto the activity stack
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsRoute()));
                },
                child: Text('Launch Notifications Screen')),
          ],
        ),
      ),
    );
  }
}

import 'package:cs361/login/login.dart';
import 'package:cs361/notifications/notification_helper.dart';
import 'package:cs361/themes.dart';
import 'package:flutter/material.dart';

//Launch app
void main() => runApp(MyApp());


//And then start off by displaying the login screen
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeNotifications(context);
    return MaterialApp(
      title: 'CS 361 Demo App',
      //Set material light theme for whole app -- no need to customize each individual widget/screen
      theme: kLightGalleryTheme,
      home: LoginRoute(),
    );
  }
}


//TODO: Set home: LoginRoute()  to home: HubRoute() if you want to skip directly to the hub for debugging
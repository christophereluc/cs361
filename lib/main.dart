import 'package:flutter/material.dart';
import 'package:cs361/themes.dart';
import 'package:cs361/login/login.dart';
import 'package:cs361/notifications/notifications.dart';

void main() {
  runApp(MyApp());
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
                child: Text('Launch Login Screen')
            ),
            RaisedButton(
                onPressed: () {
                  //Used for pushing new screens onto the activity stack
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NotificationsRoute()));
                },
                child: Text('Launch Notifications Screen')
            ),
          ],
        ),
      ),
    );
  }
}


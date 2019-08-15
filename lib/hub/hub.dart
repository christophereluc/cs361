import 'package:cs361/message/message.dart';
import 'package:cs361/notifications/notifications.dart';
import 'package:cs361/otc/otc.dart';
import 'package:flutter/material.dart';

//Hub for hosting all app functionality (besides logging in)
class HubRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Screen title
        title: Text("Home Hub"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  //Used for pushing new screens onto the activity stack
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsRoute()));
                },
                child: Text('Launch Notifications Screen')),
            RaisedButton(
                onPressed: () {
                  //Used for pushing new screens onto the activity stack
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtcRoute()));
                },
                child: Text('Launch OTC Drugs Screen')),
            RaisedButton(
                onPressed: () {
                  //Used for pushing new screens onto the activity stack
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageRoute()));
                },
                child: Text('Launch Messaging Screen')),
          ],
        ),
      ),
    );
  }
}

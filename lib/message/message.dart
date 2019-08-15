import 'package:flutter/material.dart';

//Hub for hosting all app functionality (besides logging in)
class MessageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Screen title
        title: Text("Messaging Hub"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Stuff here'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

//Hub for hosting all app functionality (besides logging in)
class OtcRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Screen title
        title: Text("OTC Hub"),
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

import 'package:flutter/material.dart';

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Username"),
            Text("Password"),
            RaisedButton(onPressed: () {}, child: Text('Login')),
            RaisedButton(
                onPressed: () {}, child: Text('Login with fingerprint')),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:cs361/login/auth_completed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'fingerprint_auth.dart';
import 'server_auth.dart';

//Login Route class -- Defines page
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
          children: <Widget>[LoginFormWidget()],
        ),
      ),
    );
  }
}

//Form Widget -- Holds login state
class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({Key key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _FormData {
  String username;
  String password;
}

//Form state
class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = _FormData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) => _formData.username = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },

              onSaved: (value) => _formData.password = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: RaisedButton(
              onPressed: _authenticate,
              child: Text('Submit'),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
              child: FingerprintAuth()),
        ],
      ),
    );
  }

  Future<void> _authenticate() async {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
      pr.setMessage("Loading");
      pr.show();

      bool authenticated;
      try {
        authenticated =
        await serverAuthenticator(_formData.username, _formData.password)
            .timeout(const Duration(seconds: 10));
      }
      catch (e) {
        print(e);
        authenticated = false;
      }

      setState(() {
        pr.hide();
        showDialogCompleted(authenticated, context);
      });
    }
  }
}
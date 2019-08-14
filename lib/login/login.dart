import 'dart:async';

import 'package:cs361/login/AuthenticateRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';

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

      bool authenticated = await _serverAuthenticator(
          _formData.username, _formData.password);

      setState(() {
        if (authenticated) _showDialog(authenticated, context);
      });
    }
  }
}

Future<bool> _serverAuthenticator(String username, String password) async {
  final response = await post('http://flip1.engr.oregonstate.edu:5893',
      body: AuthenticateRequest(username, password).toJson());
  if (response != null) {
    return AuthenticateResponse
        .fromJson(json.decode(response.body))
        .success;
  } else {
    return false;
  }
}

//Special widget for holding fingerprint auth state
class FingerprintAuth extends StatefulWidget {
  @override
  _FingerprintAuthState createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate');
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    if (authenticated) {
      authenticated = await _serverAuthenticator("chris", "pass1234");
    }

    setState(() {
      if (authenticated) _showDialog(authenticated, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      child: const Text('Authenticate with Biometrics'),
      onPressed: _authenticate,
    );
  }
}

void _showDialog(bool success, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(success
              ? "Authentication Successful!"
              : "Authentication Failed!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                //Dismiss dialog
                Navigator.of(context).pop();
                //dismiss auth screen
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
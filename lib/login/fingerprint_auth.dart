import 'dart:async';

import 'package:cs361/login/auth_completed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'server_auth.dart';

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
      //This is simulated logging in with credentials stored in the device's keychain,
      //so it's not pulling from the username/pw fields
      authenticated = await serverAuthenticator("chris", "pass1234");
    }

    setState(() {
      if (authenticated) showDialogCompleted(authenticated, context);
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

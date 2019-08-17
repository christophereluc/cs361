import 'dart:async';

import 'package:cs361/login/auth_completed_dialog.dart';
import 'package:cs361/login/authenticate_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'server_auth.dart';

//Special widget for holding fingerprint auth state
class FingerprintAuth extends StatefulWidget {
  @override
  _FingerprintAuthState createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool fingerprintAuth = false;
    try {
      fingerprintAuth = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate');
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    AuthenticateResponse authenticateResponse = null;

    if (fingerprintAuth) {
      ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
      pr.setMessage("Loading");
      pr.show();

      try {
        authenticateResponse = await serverAuthenticator("chris", "pass1234")
            .timeout(const Duration(seconds: 10));
      } catch (e) {
        print(e);
        authenticateResponse = null;
      }
      pr.hide();
    }

    setState(() {
      showDialogCompleted(authenticateResponse, context);
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

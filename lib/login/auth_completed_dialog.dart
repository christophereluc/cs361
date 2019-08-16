import 'package:cs361/hub/hub.dart';
import 'package:flutter/material.dart';

import 'authenticate_models.dart';

//Handles a the completion of the authentication flow
void showDialogCompleted(AuthenticateResponse response, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(response != null && response.success
              ? "Authentication Successful!"
              : "Authentication Failed!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                //Dismiss dialog
                Navigator.pop(context);

                //Now navigate to the hub if successful
                if (response != null && response.success) {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => HubRoute(response.user_id)));
                }
              },
            )
          ],
        );
      });
}

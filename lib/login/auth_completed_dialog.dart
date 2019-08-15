import 'package:cs361/hub/hub.dart';
import 'package:flutter/material.dart';


//Handles a the completion of the authentication flow
void showDialogCompleted(bool success, BuildContext context) {
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
                Navigator.pop(context);

                //Now navigate to the hub if successful
                if (success) {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => HubRoute()));
                }
              },
            )
          ],
        );
      });
}

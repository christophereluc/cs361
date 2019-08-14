import 'package:flutter/material.dart';

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
                Navigator.of(context).pop();

                //dismiss auth screen if successful
                if (success) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'notification_helper.dart';

class NotificationsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[NotificationFormWidget()],
        ),
      ),
    );
  }
}

class NotificationFormWidget extends StatefulWidget {
  NotificationFormWidget({Key key}) : super(key: key);

  @override
  _NotificationFormWidgetState createState() => _NotificationFormWidgetState();
}

class _FormData {
  DateTime time = DateTime.now();
  String message = '';
}

//Form state
class _NotificationFormWidgetState extends State<NotificationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = _FormData();

  DateTime dropdownValue = DateTime.now();
  final formatter = new DateFormat().add_yMd().add_Hm();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                child: Text("Select Date:"),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                  child: FlatButton(
                    child: Text(
                      formatter.format(dropdownValue),
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                            setState(() {
                              dropdownValue = date;
                              _formData.time = date;
                            });
                          });
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Notifcation message'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter text';
                }

                return null;
              },
              onSaved: (value) => _formData.message = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 32.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  //Save the state
                  _formKey.currentState.save();
                  //Then fire off notifications
                  displayNotification(
                      "Reminder!", _formData.message, _formData.time);
                  _showDialog();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Notification Scheduled!"),
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
        }
    );
  }
}

import 'package:flutter/material.dart';

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

//Form state
class _NotificationFormWidgetState extends State<NotificationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Sunday';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
             child: DropdownButton<String>(
               value: dropdownValue,
               onChanged: (String newValue) {
                 setState(() {
                   dropdownValue = newValue;
                 });
               },
                items: <String>['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Daily'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              ),
            ),
          Padding(
            padding:
            const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Time of notifcation (i.e. 1:00 pm)'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid time';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Notifcation message'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 32.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
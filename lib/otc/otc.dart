import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

//Hub for hosting all app functionality (besides logging in)
class OtcRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Screen title
        title: Text("OTC Hub"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[NewOTCFormWidget()],
        ),
      ),
    );
  }
}

class NewOTCFormWidget extends StatefulWidget {
  NewOTCFormWidget({Key key}) : super(key: key);

  @override
  _NewOTCFormWidgetState createState() => _NewOTCFormWidgetState();
}

class _FormData {
  String drugName = '';
}

//Form state
class _NewOTCFormWidgetState extends State<NewOTCFormWidget> {
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
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'New Drug Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter drug name';
                }

                return null;
              },
              onSaved: (value) => _formData.drugName = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 32.0),
            child: RaisedButton(
              onPressed: _submitDataToServer,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitDataToServer() async {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      ProgressDialog pr = ProgressDialog(context, ProgressDialogType.Normal);
      pr.setMessage("Loading");
      pr.show();

      //TODO Replace this with API call
      await Future.delayed(new Duration(seconds: 5));

      setState(() {
        pr.hide();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Data submitted"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      //Dismiss dialog
                      Navigator.pop(context);

                      //Go back to the hub
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      });
    }
  }
}

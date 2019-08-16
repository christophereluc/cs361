import 'package:cs361/otc/new_drug_model.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'new_otc_api.dart';


//Hub for hosting all app functionality (besides logging in)
class OtcRoute extends StatelessWidget {
  final int user_id;

  OtcRoute(this.user_id);

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
          children: <Widget>[NewOTCFormWidget(user_id: user_id)],
        ),
      ),
    );
  }
}

class NewOTCFormWidget extends StatefulWidget {
  final int user_id;

  NewOTCFormWidget({Key key, this.user_id}) : super(key: key);

  @override
  _NewOTCFormWidgetState createState() => _NewOTCFormWidgetState(user_id);
}

class _FormData {
  String drugName = '';
}

//Form state
class _NewOTCFormWidgetState extends State<NewOTCFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = _FormData();
  final int user_id;

  _NewOTCFormWidgetState(this.user_id);

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
      NewDrugResponse response = await submitOtcDrug(
          NewDrugRequest(_formData.drugName, user_id)).timeout(
          Duration(seconds: 10));

      setState(() {
        pr.hide();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(response != null && response.success ?
                "Data submitted" :
                "Failed submission"
                ),
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

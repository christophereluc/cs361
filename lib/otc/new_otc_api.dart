import 'dart:convert';

import 'package:http/http.dart';

import 'new_drug_model.dart';

Future<NewDrugResponse> submitOtcDrug(NewDrugRequest request) async {
  final response = await post('http://flip1.engr.oregonstate.edu:5893/otc',
      body: request.toJson());
  if (response != null) {
    return NewDrugResponse.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

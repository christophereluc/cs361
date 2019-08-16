import 'dart:convert';

import 'package:http/http.dart';

import 'authenticate_models.dart';

Future<AuthenticateResponse> serverAuthenticator(String username,
    String password) async {
  final response = await post('http://flip1.engr.oregonstate.edu:5893',
      body: AuthenticateRequest(username, password).toJson());
  if (response != null) {
    return AuthenticateResponse.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}

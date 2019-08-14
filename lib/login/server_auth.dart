import 'AuthenticateRequest.dart';
import 'package:http/http.dart';
import 'dart:convert';

Future<bool> serverAuthenticator(String username, String password) async {
  final response = await post('http://flip1.engr.oregonstate.edu:5893',
      body: AuthenticateRequest(username, password).toJson());
  if (response != null) {
    return AuthenticateResponse.fromJson(json.decode(response.body)).success;
  } else {
    return false;
  }
}

class AuthenticateRequest {
  final String username;
  final String password;

  AuthenticateRequest(this.username, this.password);

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

class AuthenticateResponse {
  final bool success;

  AuthenticateResponse({this.success});

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponse(success: json['success']);
  }
}

class AuthenticateRequest {
  final String username;
  final String password;

  AuthenticateRequest(this.username, this.password);

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

class AuthenticateResponse {
  final bool success;
  final int user_id;

  AuthenticateResponse({this.success, this.user_id});

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponse(
        success: json['success'], user_id: json['user_id']);
  }
}

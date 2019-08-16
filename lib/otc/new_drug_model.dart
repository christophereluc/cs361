//Possible API Request/Response - Change if necessary

class NewDrugRequest {
  final String drugName;
  final int user_id;

  NewDrugRequest(this.drugName, this.user_id);

  Map<String, dynamic> toJson() =>
      {'drug_name': drugName, 'user_id': user_id.toString()};
}

class NewDrugResponse {
  final bool success;

  NewDrugResponse({this.success});

  factory NewDrugResponse.fromJson(Map<String, dynamic> json) {
    return NewDrugResponse(success: json['success']);
  }
}

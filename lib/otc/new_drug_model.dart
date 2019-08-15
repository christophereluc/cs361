//Possible API Request/Response - Change if necessary

class NewDrugRequest {
  final String drugName;

  NewDrugRequest(this.drugName);

  Map<String, dynamic> toJson() => {'drug_name': drugName};
}

class NewDrugResponse {
  final bool success;

  NewDrugResponse({this.success});

  factory NewDrugResponse.fromJson(Map<String, dynamic> json) {
    return NewDrugResponse(success: json['success']);
  }
}

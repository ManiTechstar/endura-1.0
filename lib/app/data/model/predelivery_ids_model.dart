class PredeliveryIdsModel {
  int? statusCode;
  String? status;
  String? message;
  List<String>? result;

  PredeliveryIdsModel(
      {statusCode, status, message, result});

  PredeliveryIdsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    result = json['result'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['result'] = result;
    return data;
  }
}

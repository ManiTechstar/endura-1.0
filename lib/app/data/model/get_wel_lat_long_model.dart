class GetWelLatLongModel {
  int? statusCode;
  String? status;
  String? message;
  List<dynamic>? result = [];

  GetWelLatLongModel({this.statusCode, this.status, this.message, this.result});

  GetWelLatLongModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['result'] = result;
    return data;
  }
}

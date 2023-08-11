class WarehoseModel {
  int? statusCode;
  String? status;
  List<Result>? result;

  WarehoseModel({statusCode, status, message});

  WarehoseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['message'] != null) {
      result = <Result>[];
      json['message'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    if (result != null) {
      data['message'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? warehouse;
  String? createdDate;
  String? updatedDate;

  Result({sId, warehouse, createdDate, updatedDate});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    warehouse = json['warehouse'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['warehouse'] = warehouse;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

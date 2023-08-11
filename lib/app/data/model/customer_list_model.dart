class CustomerListModel {
  int? statusCode;
  String? status;
  String? message;
  List<Result>? result;

  CustomerListModel({statusCode, status, message, result});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? customerName;
  String? emailId;
  String? contactNumber;
  String? address;
  String? longitude;
  String? latitude;
  String? company;
  String? createdDate;
  String? updatedDate;

  Result(
      {sId,
      customerName,
      emailId,
      contactNumber,
      address,
      longitude,
      latitude,
      company,
      createdDate,
      updatedDate});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerName = json['customerName'];
    emailId = json['emailId'];
    contactNumber = json['contactNumber'];
    address = json['address'];
    longitude = json['longitude'].toString();
    latitude = json['latitude'].toString();
    company = json['company'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerName'] = customerName;
    data['emailId'] = emailId;
    data['contactNumber'] = contactNumber;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['company'] = company;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

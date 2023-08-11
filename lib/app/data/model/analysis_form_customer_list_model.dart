class AnalysisFormCustomerListModel {
  int? statusCode;
  String? status;
  String? message;
  List<Result>? result;

  AnalysisFormCustomerListModel({statusCode, status, message, result});

  AnalysisFormCustomerListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add( Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  String? customerId;
  String? location;
  String? county;
  String? state;
  String? createdDate;
  String? updatedDate;
  String? customerName;
  String? accountRepName;

  Result(
      {sId,
      customerId,
      location,
      county,
      state,
      createdDate,
      updatedDate,
      customerName,
      accountRepName});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    location = json['location'];
    county = json['county'];
    state = json['state'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    customerName = json['customer_name'];
    accountRepName = json['account_rep_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['customer_id'] = customerId;
    data['location'] = location;
    data['county'] = county;
    data['state'] = state;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['customer_name'] = customerName;
    data['account_rep_name'] = accountRepName;
    return data;
  }
}
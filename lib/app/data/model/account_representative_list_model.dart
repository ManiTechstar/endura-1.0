class AccountRepresentativeListModel {
  int? statusCode;
  String? status;
  String? message;
  List<AccountRepresentativeListModelResult>? result;

  AccountRepresentativeListModel({statusCode, status, message, result});

  AccountRepresentativeListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <AccountRepresentativeListModelResult>[];
      json['result'].forEach((v) {
        result!.add(AccountRepresentativeListModelResult.fromJson(v));
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

class AccountRepresentativeListModelResult {
  String? sId;
  String? name;
  String? email;
  String? role;

  AccountRepresentativeListModelResult({sId, name, email, role});

  AccountRepresentativeListModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}

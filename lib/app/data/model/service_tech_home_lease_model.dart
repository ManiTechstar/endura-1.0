class ServiceTechHomeLeaseModel {
  int? statusCode;
  String? status;
  String? message;
  List<ServiceTechHomeLeaseModelResult>? result = [];

  ServiceTechHomeLeaseModel({statusCode, status, message, result});

  ServiceTechHomeLeaseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <ServiceTechHomeLeaseModelResult>[];
      json['result'].forEach((v) {
        result!.add(ServiceTechHomeLeaseModelResult.fromJson(v));
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

class ServiceTechHomeLeaseModelResult {
  String? sId;
  String? location;
  String? deliveryLocation;
  String? county;
  String? state;
  String? deliveryAddress;

  ServiceTechHomeLeaseModelResult(
      {sId, location, deliveryLocation, county, state, deliveryAddress});

  ServiceTechHomeLeaseModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'];
    deliveryLocation = json['delivery_location'];
    county = json['county'] ?? '';
    state = json['state'];
    deliveryAddress = json['delivery_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['location'] = location;
    data['delivery_location'] = deliveryLocation;
    data['county'] = county;
    data['state'] = state;
    data['delivery_address'] = deliveryAddress;
    return data;
  }
}

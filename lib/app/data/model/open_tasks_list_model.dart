import 'package:endura_app/core/utilities/date_utility.dart';

class OpenTasksListModel {
  OpenTasksListModel();
  int? statusCode;
  String? status;
  String? message;
  List<OpenTask>? result;

  OpenTasksListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <OpenTask>[];
      json['result'].forEach((v) {
        result!.add(OpenTask.fromJson(v));
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

class OpenTask {
  String? sId;
  String? employeeId;
  String? userEmail;
  String? customerName;
  String? employeeName;
  String? accRep;
  String? taskName;
  String? customer;
  String? leaseLocation;
  String? route;
  String? circulate;
  String? comment;
  String? description;
  String? taskStatus;
  Location? location;
  bool? isAssigned;
  List<Products>? products;
  DateTime? startDate;
  String? endDate;
  String? createdDate;
  String? updatedDate;
  String? taskStartsFrom;
  bool? isSelected = false;

  OpenTask(
      {sId,
      employeeId,
      userEmail,
      customerName,
      employeeName,
      accRep,
      taskName,
      customer,
      leaseLocation,
      route,
      circulate,
      comment,
      description,
      taskStatus,
      location,
      isAssigned,
      products,
      startDate,
      endDate,
      createdDate,
      taskStartsFrom,
      updatedDate});

  OpenTask.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    employeeId = json['employeeId'];
    userEmail = json['user_email'];
    customerName = json['customerName'];
    employeeName = json['employeeName'];
    accRep = json['accRep'];
    taskName = json['task_name'];
    customer = json['customer'];
    leaseLocation = json['leaseLocation'];
    route = json['route'];
    circulate = json['circulate'];
    comment = json['comment'];
    description = json['description'];
    taskStatus = json['task_status'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    isAssigned = json['is_assigned'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    startDate =
        DateUtility().convertStringToDate(stringDate: json['startDate']);
    taskStartsFrom =
        DateUtility().taskStartsFrom(stringDate: json['startDate']);
    endDate = json['endDate'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['employeeId'] = employeeId;
    data['user_email'] = userEmail;
    data['customerName'] = customerName;
    data['employeeName'] = employeeName;
    data['accRep'] = accRep;
    data['task_name'] = taskName;
    data['customer'] = customer;
    data['leaseLocation'] = leaseLocation;
    data['route'] = route;
    data['circulate'] = circulate;
    data['comment'] = comment;
    data['description'] = description;
    data['task_status'] = taskStatus;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['is_assigned'] = isAssigned;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

class Location {
  String? latitude;
  String? longitude;
  String? address;

  Location({latitude, longitude, address});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    return data;
  }
}

class Products {
  String? productId;
  String? frequencyOfLoad;
  String? uomGal;

  Products({productId, frequencyOfLoad, uomGal});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    frequencyOfLoad = json['frequencyOfLoad'];
    uomGal = json['uom_gal'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['frequencyOfLoad'] = frequencyOfLoad;
    data['uom_gal'] = uomGal;
    return data;
  }
}

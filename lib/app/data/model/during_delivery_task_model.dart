class DuringDeliveryTaskModel {
  DuringDeliveryTaskModel({
    this.statusCode,
    this.status,
    this.message,
    this.result,
  });
  int? statusCode;
  String? status;
  String? message;
  List<Result>? result;

  DuringDeliveryTaskModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['status'] = status;
    _data['message'] = message;
    _data['result'] = result!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.employeeId,
    required this.userEmail,
    required this.customerName,
    required this.employeeName,
    this.accRep,
    required this.taskName,
    required this.customer,
    required this.leaseLocation,
    required this.route,
    required this.circulate,
    this.comment,
    this.description,
    required this.taskStatus,
    required this.location,
    required this.products,
    required this.startDate,
    required this.endDate,
    required this.createdDate,
    required this.updatedDate,
    this.completedDate,
  });
  late final String id;
  late final String employeeId;
  late final String userEmail;
  late final String customerName;
  late final String employeeName;
  late final String? accRep;
  late final String taskName;
  late final String customer;
  late final String leaseLocation;
  late final String route;
  late final String circulate;
  late final String? comment;
  late final String? description;
  late final String taskStatus;
  late final Location location;
  late final List<Products> products;
  late final String startDate;
  late final String endDate;
  late final String createdDate;
  late final String updatedDate;
  late final String? completedDate;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    employeeId = json['employeeId'];
    userEmail = json['user_email'];
    customerName = json['customerName'];
    employeeName = json['employeeName'];
    accRep = null;
    taskName = json['task_name'];
    customer = json['customer'];
    leaseLocation = json['leaseLocation'];
    route = json['route'];
    circulate = json['circulate'];
    comment = null;
    description = null;
    taskStatus = json['task_status'];
    location = Location.fromJson(json['location']);
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    completedDate = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['employeeId'] = employeeId;
    _data['user_email'] = userEmail;
    _data['customerName'] = customerName;
    _data['employeeName'] = employeeName;
    _data['accRep'] = accRep;
    _data['task_name'] = taskName;
    _data['customer'] = customer;
    _data['leaseLocation'] = leaseLocation;
    _data['route'] = route;
    _data['circulate'] = circulate;
    _data['comment'] = comment;
    _data['description'] = description;
    _data['task_status'] = taskStatus;
    _data['location'] = location.toJson();
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['createdDate'] = createdDate;
    _data['updatedDate'] = updatedDate;
    _data['completedDate'] = completedDate;
    return _data;
  }
}

class Location {
  Location({
    this.latitude,
    this.longitude,
    required this.address,
  });
  late final String? latitude;
  late final String? longitude;
  late final String address;

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    address = json['address'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['address'] = address;
    return _data;
  }
}

class Products {
  Products({
    required this.productId,
    required this.frequencyOfLoad,
    required this.uomGal,
  });
  late final String productId;
  late final String frequencyOfLoad;
  late final String uomGal;

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    frequencyOfLoad = json['frequencyOfLoad'];
    uomGal = json['uom_gal'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['frequencyOfLoad'] = frequencyOfLoad;
    _data['uom_gal'] = uomGal;
    return _data;
  }
}

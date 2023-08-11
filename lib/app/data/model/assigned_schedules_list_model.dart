class AssignedSchedulesListModel {
  int? statusCode;
  String? status;
  String? message;
  List<Result>? result = [];
  AssignedSchedulesListModel();

  AssignedSchedulesListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json.containsKey('result')) {
      if (json['result'] != null) {
        result = <Result>[];
        // for (int i = 0; i < json['result'].length; i++) {
        //   if (i == 7) {
        //     print('ASSIGNED TASKS I value ==> $i');
        //   }
        //   result!.add(Result.fromJson(json['result'][i]));
        // }
        json['result'].forEach((v) {
          result!.add(Result.fromJson(v));
        });
      }
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
  String? userEmail;
  String? date;
  List<String>? tasks;
  List<TaskDetails>? taskDetails;
  String? dateStatus;

  Result({sId, userEmail, date, tasks, taskDetails, dateStatus});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userEmail = json['user_email'];
    date = json['date'];
    tasks = json['tasks'].cast<String>();
    if (json['task_details'] != null) {
      taskDetails = <TaskDetails>[];
      json['task_details'].forEach((v) {
        taskDetails!.add(TaskDetails.fromJson(v));
      });
    }
    dateStatus = json['date_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_email'] = userEmail;
    data['date'] = date;
    data['tasks'] = tasks;
    if (taskDetails != null) {
      data['task_details'] = taskDetails!.map((v) => v.toJson()).toList();
    }
    data['date_status'] = dateStatus;
    return data;
  }
}

class TaskDetails {
  String? sId;
  String? employeeId;
  String? userEmail;
  String? accRep;
  String? taskName;
  String? customer;
  String? customerName;
  String? employeeName;
  String? leaseLocation;
  String? frequency;
  String? route;
  String? circulate;
  String? comment;
  String? description;
  String? taskStatus;
  Location? location;
  List<Products>? products;
  String? startDate;
  String? endDate;
  String? createdDate;
  String? updatedDate;
  String? dateStatus;
  bool isCheckedForPreDelivery = false;

  TaskDetails(
      {sId,
      employeeId,
      userEmail,
      accRep,
      taskName,
      customer,
      customerName,
      employeeName,
      leaseLocation,
      frequency,
      route,
      circulate,
      comment,
      description,
      taskStatus,
      location,
      products,
      startDate,
      endDate,
      createdDate,
      updatedDate,
      dateStatus});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    employeeId = json['employeeId'];
    userEmail = json['user_email'];
    accRep = json['accRep'];
    taskName = json['task_name'];
    customer = json['customer'];
    customerName = json['customerName'];
    employeeName = json['employeeName'];
    leaseLocation = json['leaseLocation'];
    frequency = json['frequency'];
    route = json['route'];
    circulate = json['circulate'];
    comment = json['comment'];
    description = json['description'];
    taskStatus = json['task_status'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    dateStatus = json['date_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['employeeId'] = employeeId;
    data['user_email'] = userEmail;
    data['accRep'] = accRep;
    data['task_name'] = taskName;
    data['customer'] = customer;
    data['customerName'] = customerName;
    data['employeeName'] = employeeName;
    data['leaseLocation'] = leaseLocation;
    data['frequency'] = frequency;
    data['route'] = route;
    data['circulate'] = circulate;
    data['comment'] = comment;
    data['description'] = description;
    data['task_status'] = taskStatus;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['date_status'] = dateStatus;
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

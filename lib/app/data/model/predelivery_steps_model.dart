class PredeliveryStepsModel {
  int? statusCode;
  String? status;
  String? message;
  List<Result>? result;

  PredeliveryStepsModel({statusCode, status, message, result});

  PredeliveryStepsModel.fromJson(Map<String, dynamic> json) {
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
  String? taskId;
  List<SubsTasks>? subsTasks;

  Result({taskId, subsTasks});

  Result.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    if (json['subs_tasks'] != null) {
      subsTasks = <SubsTasks>[];
      json['subs_tasks'].forEach((v) {
        subsTasks!.add(SubsTasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    if (subsTasks != null) {
      data['subs_tasks'] = subsTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubsTasks {
  String? sId;
  String? subTaskName;
  String? status;
  List<SubTaskSteps>? subTaskSteps;

  SubsTasks({sId, subTaskName, status, subTaskSteps});

  SubsTasks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subTaskName = json['sub_task_name'];
    status = json['status'];
    if (json['sub_task_steps'] != null) {
      subTaskSteps = <SubTaskSteps>[];
      json['sub_task_steps'].forEach((v) {
        subTaskSteps!.add(SubTaskSteps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sub_task_name'] = subTaskName;
    data['status'] = status;
    if (subTaskSteps != null) {
      data['sub_task_steps'] = subTaskSteps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubTaskSteps {
  String? stepName;

  String? stepDescription;
  String? stepStatus;
  bool? isSelected = false;
  List<InspectionSteps>? inspectionSteps;
  List<Products>? products;

  SubTaskSteps(
      {stepName, stepDescription, stepStatus, inspectionSteps, products});

  SubTaskSteps.fromJson(Map<String, dynamic> json) {
    stepName = json['step_name'];
    stepDescription = json['step_description'];
    stepStatus = json['step_status'];
    if (json['inspection_steps'] != null) {
      inspectionSteps = <InspectionSteps>[];
      json['inspection_steps'].forEach((v) {
        inspectionSteps!.add(InspectionSteps.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step_name'] = stepName;
    data['step_description'] = stepDescription;
    data['step_status'] = stepStatus;
    if (inspectionSteps != null) {
      data['inspection_steps'] =
          inspectionSteps!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InspectionSteps {
  String? stepName;
  String? stepStatus;

  InspectionSteps({stepName, stepStatus});

  InspectionSteps.fromJson(Map<String, dynamic> json) {
    stepName = json['step_name'];
    stepStatus = json['step_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step_name'] = stepName;
    data['step_status'] = stepStatus;
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

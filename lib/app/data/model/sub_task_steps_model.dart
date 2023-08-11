
class SubTaskStepData {
  String? stepName;
  String? stepDescription;
  String? stepStatus;
  List<NotTreatedSteps>? notTreatedSteps;
  List<Products>? products;
  String? notTreated;
  List<SafetyCheck>? safetyCheck;
  bool? isSelected = false;

  SubTaskStepData(
      {this.stepName,
      this.stepDescription,
      this.stepStatus,
      this.notTreatedSteps,
      this.notTreated,
      this.safetyCheck,
      this.isSelected});

  SubTaskStepData.fromJson(Map<dynamic, dynamic> json) {
    stepName = json['step_name'];
    if (json['not_treated_steps'] != null) {
      notTreatedSteps = <NotTreatedSteps>[];
      json['not_treated_steps'].forEach((v) {
        notTreatedSteps!.add(NotTreatedSteps.fromJson(v));
      });
    }

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }

    
    notTreated = json['not_treated'];



    stepDescription = json['step_description'];
    stepStatus = json['step_status'];
    if (json['safety_check'] != null) {
      safetyCheck = <SafetyCheck>[];
      json['safety_check'].forEach((v) {
        safetyCheck!.add(SafetyCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step_name'] = stepName;

    data['step_description'] = stepDescription;
    data['step_status'] = stepStatus;
    if (notTreatedSteps != null) {
      data['not_treated_steps'] =
          notTreatedSteps!.map((v) => v.toJson()).toList();
    }
    data['not_treated'] = notTreated;
    if (safetyCheck != null) {
      data['safety_check'] = safetyCheck!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SafetyCheck {
  String? stepName;
  String? stepStatus;

  SafetyCheck({this.stepName, this.stepStatus});

  SafetyCheck.fromJson(Map<String, dynamic> json) {
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

class InspectionSteps {
  String? stepName;
  String? stepStatus;

  InspectionSteps({this.stepName, this.stepStatus});

  InspectionSteps.fromJson(Map<dynamic, dynamic> json) {
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

class NotTreatedSteps {
  String? stepName;
  String? stepStatus;

  NotTreatedSteps({this.stepName, this.stepStatus});

  NotTreatedSteps.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['product_id'] = productId;
    data['frequencyOfLoad'] = frequencyOfLoad;
    data['uom_gal'] = uomGal;
    return data;
  }
}

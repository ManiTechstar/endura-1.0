class LeasesModel {
  int? statusCode;
  String? status;
  List<LeasesResult>? result;

  LeasesModel({statusCode, status, message});

  LeasesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['message'] != null) {
      result = <LeasesResult>[];
      json['message'].forEach((v) {
        result!.add( LeasesResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    if (result != null) {
      data['message'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeasesResult {
  String? sId;
  String? customerId;
  String? location;
  String? accountRepId;
  List<LeaseProducts>? products;
  String? county;
  String? state;
  String? createdDate;
  String? updatedDate;

  LeasesResult(
      {sId,
      customerId,
      location,
      accountRepId,
      products,
      county,
      state,
      createdDate,
      updatedDate});

  LeasesResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    location = json['location'];
    accountRepId = json['account_rep_id'];
    if (json['products'] != null) {
      products = <LeaseProducts>[];
      json['products'].forEach((v) {
        products!.add( LeaseProducts.fromJson(v));
      });
    }
    county = json['county'];
    state = json['state'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['customer_id'] = customerId;
    data['location'] = location;
    data['account_rep_id'] = accountRepId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['county'] = county;
    data['state'] = state;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

class LeaseProducts {
  String? productId;
  String? frequencyOfLoad;
  String? uomGal;

  LeaseProducts({productId, frequencyOfLoad, uomGal});

  LeaseProducts.fromJson(Map<String, dynamic> json) {
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
class ProductsByLocationModel {
  int? statusCode;
  String? status;
  List<ProductsResult>? result;
  

  ProductsByLocationModel({statusCode, status, message});

  ProductsByLocationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['message'] != null) {
      result = <ProductsResult>[];
      json['message'].forEach((v) {
        result!.add( ProductsResult.fromJson(v));
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

class ProductsResult {
  String? sId;
  String? customerId;
  String? location;
  List<Products>? products;
  String? county;
  String? state;
  String? createdDate;
  String? updatedDate;

  ProductsResult(
      {sId,
      customerId,
      location,
      products,
      county,
      state,
      createdDate,
      updatedDate});

  ProductsResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    location = json['location'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
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
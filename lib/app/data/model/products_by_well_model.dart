class ProductsByWellModel {
  int? statusCode;
  String? status;
  List<Products>? products;

  ProductsByWellModel({statusCode, status, message});

  ProductsByWellModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['result'] != null) {
      products = <Products>[];
      json['result'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    if (products != null) {
      data['result'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  String? frequencyOfLoad;
  dynamic uomGal;

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

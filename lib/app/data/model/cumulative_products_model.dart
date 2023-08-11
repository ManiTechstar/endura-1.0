class CumulativeProductsModel {
  int? statusCode;
  String? status;
  String? message;
  List<Product>? products;
  

  CumulativeProductsModel({statusCode, status, message, result});

  CumulativeProductsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      products = <Product>[];
      json['result'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

}

class Product {
  String? productId;
  dynamic uom_gal;

  Product({this.productId, this.uom_gal});

  Product.fromJson(Map<dynamic, dynamic> json) {
    productId = json['product_id'];
    uom_gal = json['uom_gal'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['uom_gal'] = uom_gal;
    return data;
  }
}

import 'dart:convert';

import 'package:fieldapp/app/data/model/products_by_location_model.dart';
import 'package:fieldapp/app/data/model/products_by_well_model.dart';
import 'package:fieldapp/core/base/services/base_http_client.dart';

class ServiceReportProvider extends BaseHttpClient {
  Future<ProductsByLocationModel> getProductsByLocation(
      {customerId, location}) async {
    final response = await post('/well_customer/get_products_by_location',
        body: {"location": location, "customer_id": customerId});
    final responseBody = jsonDecode(response.body);
    ProductsByLocationModel model =
        ProductsByLocationModel.fromJson(responseBody);
    return model;
  }

  Future<ProductsByWellModel> getProductsByWellId({wellId}) async {
    try {
      final response = await get(
        '/well_customer/getServiceProducts?well_id=$wellId',
      );
      final responseBody = jsonDecode(response.body);
      ProductsByWellModel model = ProductsByWellModel.fromJson(responseBody);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> submitServiceReport({params}) async {
    final response =
        await post('/service_report/insert_service_report', body: params);
    final responseBody = jsonDecode(response.body);
    return responseBody['message'];
  }
}

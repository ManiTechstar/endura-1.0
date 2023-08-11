import 'dart:convert';

import 'package:endura_app/core/base/services/base_http_client.dart';

class ServiceTechProvider extends BaseHttpClient {
  Future<String> injectServiceTaskProducts({params}) async {
    try {
      final response =
          await post('/well_customer/deliverServiceProducts', body: params);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> serviceTechTargetInjectApi({params}) async {
    try {
      final response =
          await post('/well_customer/enterRateOfServiceProducts', body: params);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody['message'];
    } catch (e) {
      rethrow;
    }
  }
}

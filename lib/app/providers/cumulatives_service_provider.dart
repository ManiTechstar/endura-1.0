import 'dart:convert';

import 'package:fieldapp/app/data/model/cumulative_products_model.dart';
import 'package:fieldapp/core/base/services/base_http_client.dart';
import 'package:fieldapp/core/utilities/date_utility.dart';

class CumulativesServiceProvider extends BaseHttpClient {
  Future<CumulativeProductsModel> getTodaysProductByRoute({routeName}) async {
    final response =
        await post('/well_customer/cumulative_count_of_products', body: {
      "route": routeName,
      "date": DateUtility()
          .convertStringToDate(stringDate: DateTime.now().toString())
          .toString(), //DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()
    });
    final responseBody = jsonDecode(response.body);
    CumulativeProductsModel model =
        CumulativeProductsModel.fromJson(responseBody);
    return model;
  }

  Future<CumulativeProductsModel> getCumulativeProducts(
      {routeName, email}) async {
    final response = await get(
      '/well_customer/cummulativeProducts?user_email=$email&startDate=${DateUtility().convertStringToDate(stringDate: DateTime.now().toString()).toString()}&route=$routeName',
    );
    final responseBody = jsonDecode(response.body);
    CumulativeProductsModel model =
        CumulativeProductsModel.fromJson(responseBody);
    return model;
  }
}

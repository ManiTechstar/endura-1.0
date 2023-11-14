import 'dart:convert';

import 'package:fieldapp/app/data/model/get_wel_lat_long_model.dart';
import 'package:fieldapp/core/base/services/base_http_client.dart';

class WellDetailsProvider extends BaseHttpClient {
  Future<String> updateLatLongsForWell({params}) async {
    final response =
        await post('/well_customer/set_well_coordinates', body: params);
    final responseBody = jsonDecode(response.body);
    return responseBody['message'];
  }

  Future<GetWelLatLongModel> getLatLongsForWell({params}) async {
    final response =
        await post('/well_customer/get_well_coordinates', body: params);

    final responseBody = jsonDecode(response.body);

    return GetWelLatLongModel.fromJson(responseBody);
  }
}

import 'dart:convert';

import 'package:fieldapp/app/data/model/predelivery_ids_model.dart';
import 'package:fieldapp/app/data/model/predelivery_steps_model.dart';
import 'package:fieldapp/core/base/services/base_http_client.dart';

class PredeliveryServiceProvider extends BaseHttpClient {
  Future<PredeliveryStepsModel> getPredeliverySelectiveSteps({params}) async {
    try {
      final response = await post('/task/selectiveSteps', body: params);

      final responseBody = jsonDecode(response.body);

      print(responseBody);
      PredeliveryStepsModel model =
          PredeliveryStepsModel.fromJson(responseBody);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future updateSubtaskStatus({required Map<String, dynamic> params}) async {
    try {
      print('params');
      print(params);
      final response =
          await post('/task/update_SelectiveSubTask', body: params);

      final responseBody = jsonDecode(response.body);

      print(responseBody);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> completePredelivery(
      {required Map<String, dynamic> params}) async {
    try {
      print('params');
      print(params);
      final response = await put('/task/completePreDelivery', body: params);

      final responseBody = jsonDecode(response.body);

      print(responseBody);
      return responseBody['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<PredeliveryIdsModel> todayPredeliveryStatus(
      {required String email}) async {
    try {
      final response =
          await get('/user/checkTodayPreDelivery?user_email=$email');

      final responseBody = jsonDecode(response.body);

      print(responseBody);

      PredeliveryIdsModel model = PredeliveryIdsModel.fromJson(responseBody);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}

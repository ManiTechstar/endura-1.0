import 'dart:convert';

import 'package:fieldapp/app/data/model/delivery_steps_model.dart';
import 'package:fieldapp/app/data/model/during_delivery_task_model.dart';
import 'package:fieldapp/core/base/services/base_http_client.dart';

class DuringdeliveryServiceProvider extends BaseHttpClient {
  Future getDuringDeliverySteps({taskId}) async {
    try {
      final response = await get('/task/getDuringDelivery?task_id=$taskId');

      final responseBody = jsonDecode(response.body);

      print(responseBody);
      DeliverStepsyModel model = DeliverStepsyModel.fromJson(responseBody);
      print(model.message);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<DuringDeliveryTaskModel> getTaskDetails({params}) async {
    try {
      final response = await post('/task/getTaskDetails', body: params);

      final responseBody = jsonDecode(response.body);

      print(responseBody);
      DuringDeliveryTaskModel model =
          DuringDeliveryTaskModel.fromJson(responseBody);
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
      // PredeliveryStepsModel model =
      //     PredeliveryStepsModel.fromJson(responseBody);
      // return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> completeTask({required Map<String, dynamic> params}) async {
    try {
      final response = await put('/task/completeDuringDelivery', body: params);

      final responseBody = jsonDecode(response.body);

      print(responseBody);

      return responseBody['message'];
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';

import 'package:endura_app/app/data/model/assigned_schedules_list_model.dart';
import 'package:endura_app/app/data/model/open_tasks_list_model.dart';
import 'package:endura_app/core/base/services/base_http_client.dart';

class ScheduleServiceProvider extends BaseHttpClient {
  Future<OpenTasksListModel> getOpenSchedules({params}) async {
    final response = await post('/user/get_open_tasks', body: params);
    final responseBody = jsonDecode(response.body);
    OpenTasksListModel model = OpenTasksListModel.fromJson(responseBody);
    return model;
  }

  Future<AssignedSchedulesListModel> getUserSchedules({params}) async {
    final response = await post('/user/user_schedule_test', body: params);
    final responseBody = jsonDecode(response.body);
    AssignedSchedulesListModel model =
        AssignedSchedulesListModel.fromJson(responseBody);
    return model;
  }

  Future<String> pickATask({params}) async {
    final response = await post('/task/pick_task', body: params);

    final responseBody = jsonDecode(response.body);
    return responseBody['message'];
  }

  Future<String> moveTasksToInprogress({params}) async {
    final response = await put('/task/updateTaskStatus', body: params);

    final responseBody = jsonDecode(response.body);
    return responseBody['message'];
  }

  Future<String> pickMultiTasks({params}) async {
    final response = await post('/task/pickMultipleTasks', body: params);

    final responseBody = jsonDecode(response.body);
    
    return responseBody['message'];
  }
}

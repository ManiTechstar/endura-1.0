

import 'package:fieldapp/app/data/model/sub_task_steps_model.dart';

class DeliverStepsyModel {
  DeliverStepsyModel({
    this.statusCode,
    this.status,
    this.message,
    this.result,
  });
  int? statusCode;
  String? status;
  String? message;
  Result? result;

  DeliverStepsyModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['status'] = status;
    _data['message'] = message;
    _data['result'] = result!.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.taskId,
    required this.employeeId,
    required this.userEmail,
    required this.subTaskName,
    required this.status,
    required this.subTaskSteps,
    required this.createdDate,
    required this.updatedDate,
    this.completedDate,
  });
  late final String id;
  late final String taskId;
  late final String employeeId;
  late final String userEmail;
  late final String subTaskName;
  late final String status;
  late final List<SubTaskStepData> subTaskSteps;
  late final String createdDate;
  late final String updatedDate;
  late final String? completedDate;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    taskId = json['task_id'];
    employeeId = json['employeeId'];
    userEmail = json['user_email'];
    subTaskName = json['sub_task_name'];
    status = json['status'];
    subTaskSteps = List.from(json['sub_task_steps'])
        .map((e) => SubTaskStepData.fromJson(e))
        .toList();
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    completedDate = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['task_id'] = taskId;
    _data['employeeId'] = employeeId;
    _data['user_email'] = userEmail;
    _data['sub_task_name'] = subTaskName;
    _data['status'] = status;
    _data['sub_task_steps'] = subTaskSteps.map((e) => e.toJson()).toList();
    _data['createdDate'] = createdDate;
    _data['updatedDate'] = updatedDate;
    _data['completedDate'] = completedDate;
    return _data;
  }
}


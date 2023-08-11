
import 'package:endura_app/app/data/model/sub_task_steps_model.dart';

class TaskData {
  String? id;
  String? taskId;
  String? subTaskName;
  String? taskStatus;
  List<SubTaskStepData>? subTaskSteps;

  TaskData(
      {this.id,
      this.taskId,
      this.subTaskName,
      this.taskStatus,
      this.subTaskSteps});

  Map<String, dynamic> toJson() => {
        '_id': id,
        'task_id': taskId,
        'task_name': subTaskName,
        'task_status': taskStatus,
        'sub_task_steps': subTaskSteps == null
            ? []
            : List<dynamic>.from(subTaskSteps!.map((e) => e)).toList()
      };

  TaskData.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    taskId = json['task_id'];
    subTaskName = json['sub_task_name'];
    taskStatus = json['status'];
    if (json['sub_task_steps'] != null) {
      subTaskSteps = <SubTaskStepData>[];
      json['sub_task_steps'].forEach((v) {
        subTaskSteps!.add(SubTaskStepData.fromJson(v));
      });
    }
  }
}

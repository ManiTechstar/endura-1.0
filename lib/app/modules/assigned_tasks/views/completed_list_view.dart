import 'package:endura_app/app/data/model/assigned_schedules_list_model.dart';
import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/utilities/date_utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CompletedListView extends GetView<AssignedTasksController> {
  const CompletedListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<TaskDetails> items = controller.completedList.value;
      return Expanded(
        child: controller.apiState.value == APIState.LOADING
            ? const LoaderView()
            : controller.completedList.value.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      TaskDetails task = items[index];
                      return Container(
                        padding: const EdgeInsets.only(
                            top: 15, left: 20, right: 10, bottom: 15),
                        margin: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green),
                        child: InkWell(
                            onTap: () {
                              controller.viewTaskDetails(
                                openTask: task,
                                showActionButton: false,
                                );
                            },
                            child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${task.taskName!} to ${task.leaseLocation} Well on ${task.startDate.toString().substring(0, 10)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        fontFamily: FontFamilyConstants
                                            .mulishExtraBold),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Status  :  ${task.taskStatus}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        fontFamily: FontFamilyConstants
                                            .mulishExtraBold),
                                  ),
                                ],
                              )

                            ),
                      );
                    })
                : Center(
                    child: Text(
                      "No tasks are available",
                      style: TextStyle(
                          color: ColorConstants.black1.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          fontFamily: FontFamilyConstants.mulishExtraBold),
                    ),
                  ),
      );
    });
  }
}

import 'package:fieldapp/app/data/model/assigned_schedules_list_model.dart';
import 'package:fieldapp/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:fieldapp/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TodoListView extends GetView<AssignedTasksController> {
  const TodoListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<TaskDetails> items = controller.todosList.value;
      return Expanded(
        child: controller.apiState.value == APIState.LOADING
            ? const LoaderView()
            : controller.todosList.value.isNotEmpty
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
                            color: const Color.fromARGB(204, 255, 113, 5)),
                        child: InkWell(
                          onTap: () {
                            DriverHomeController homeController =
                                Get.find<DriverHomeController>();
                            controller.viewTaskDetails(
                                openTask: task,
                                showActionButton: homeController
                                    .predeliveryIdsModel.value.result!.isEmpty,
                                action: () {
                                  items[index].isCheckedForPreDelivery =
                                      !items[index].isCheckedForPreDelivery;
                                  controller.selectItem(items);
                                  Get.back();
                                });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
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
                                ),
                              ),
                              controller.selectedTab.value == SelectTab.PENDING
                                  ? InkWell(
                                      onTap: () {
                                        items[index].isCheckedForPreDelivery =
                                            !items[index]
                                                .isCheckedForPreDelivery;
                                        controller.selectItem(items);
                                      },
                                      child: _checkBox(
                                          icon: task.isCheckedForPreDelivery
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank))
                                  : const SizedBox()
                            ],
                          ),
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

  _checkBox({icon, onClick}) {
    DriverHomeController homeController = Get.find<DriverHomeController>();
    return homeController.predeliveryIdsModel.value.result!.isNotEmpty
        ? const SizedBox()
        : InkWell(
            onTap: onClick,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
          );
  }
}

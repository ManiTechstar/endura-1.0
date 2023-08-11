import 'package:endura_app/app/data/model/during_delivery_task_model.dart';
import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:endura_app/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/during_delivery_tasks_list_controller.dart';

class DuringDeliveryTasksListView
    extends GetView<DuringDeliveryTasksListController> {
  const DuringDeliveryTasksListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Delivery',
        hasBackButton: true,
        onBackButtonPressed: () {
          Navigator.popUntil(context, ModalRoute.withName(Routes.DASHBOARD));
          Get.find<DriverHomeController>().getTodayPredeliveryStatus();
          Get.find<AssignedTasksController>().getUserTasks();
        },
      ),
      body: SafeArea(
        child: Obx(() {
          return controller.apiState.value == APIState.LOADING
              ? const LoaderView()
              : _mainUI();
        }),
      ),
    );
  }

  _mainUI() {
    List<Result> items = controller.model.value.result!;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          Result task = items[index];
          return Container(
            padding:
                const EdgeInsets.only(top: 15, left: 20, right: 10, bottom: 15),
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstants.color5),
            child: InkWell(
                onTap: () {
                  if (items[index].taskStatus.toLowerCase() == 'pending') {
                    controller.selectedTaskId.value = task.id;
                    Get.toNamed(Routes.DURING_DELIVERY);
                  } else {
                    SnackbarSupporter.showSuccessSnackbar(
                        title: '',
                        message: 'This ${task.taskName} is already completed');
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${task.taskName} to ${task.leaseLocation} Well on ${task.startDate.toString().substring(0, 10)}',
                      style: TextStyle(
                          color: ColorConstants.black1,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: FontFamilyConstants.mulishExtraBold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Status  :  ${task.taskStatus}',
                      style: TextStyle(
                          color: ColorConstants.black1,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: FontFamilyConstants.mulishExtraBold),
                    ),
                  ],
                )),
          );
        });
  }
}

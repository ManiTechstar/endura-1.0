import 'package:fieldapp/app/modules/assigned_tasks/views/completed_list_view.dart';
import 'package:fieldapp/app/modules/assigned_tasks/views/failed_list_view.dart';
import 'package:fieldapp/app/modules/assigned_tasks/views/todo_list_view.dart';
import 'package:fieldapp/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:fieldapp/core/base/views/base_app_bar.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';

import 'package:fieldapp/core/utilities/snackbar_supporter.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/assigned_schedules_list_model.dart';
import '../controllers/assigned_tasks_controller.dart';

class AssignedTasksView extends GetView<AssignedTasksController> {
  const AssignedTasksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => controller.selectedTab.value == SelectTab.PENDING
            ? _bottomButtons(controller.todosList.value
                .where((element) =>
                    element.taskStatus!.toLowerCase() == 'pending' &&
                    element.isCheckedForPreDelivery)
                .toList())
            : const BottomAppBar(
                height: 0.0,
              ),
      ),
      appBar: const BaseAppBar(
        title: 'Assigned',
        hasBackButton: true,
      ),
      body: Obx(
        () => Column(
          children: [
            _tabBar(),
            Container(
              height: 1.0,
              width: double.infinity,
              color: ColorConstants.black1,
            ),
            controller.selectedTab.value == SelectTab.FAIL
                ? const FailedListView()
                : controller.selectedTab.value == SelectTab.PENDING
                    ? const TodoListView()
                    : const CompletedListView(),
            //  _openTaskListWidget()
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _tab(
          text: 'PENDING',
          weight: controller.selectedTab.value == SelectTab.PENDING
              ? FontWeight.w700
              : FontWeight.normal,
          lableColor: controller.selectedTab.value == SelectTab.PENDING
              ? Colors.white
              : ColorConstants.black1,
          bgColor: controller.selectedTab.value == SelectTab.PENDING
              ? ColorConstants.black1
              : Colors.white,
          onClick: () {
            if (controller.selectedTab.value != SelectTab.PENDING) {
              controller.selectedTab.value = SelectTab.PENDING;
            }
          },
        ),
        Container(
          height: 30.0,
          width: 1.0,
          color: ColorConstants.black1,
        ),
        _tab(
          text: 'COMPLETED',
          weight: controller.selectedTab.value == SelectTab.COMPLETED
              ? FontWeight.w700
              : FontWeight.normal,
          lableColor: controller.selectedTab.value == SelectTab.COMPLETED
              ? Colors.white
              : ColorConstants.black1,
          bgColor: controller.selectedTab.value == SelectTab.COMPLETED
              ? ColorConstants.black1
              : Colors.white,
          onClick: () {
            if (controller.selectedTab.value != SelectTab.COMPLETED) {
              controller.selectedTab.value = SelectTab.COMPLETED;
            }
          },
        ),
        Container(
          height: 30.0,
          width: 1.0,
          color: ColorConstants.black1,
        ),
        _tab(
          text: 'FAILED',
          weight: controller.selectedTab.value == SelectTab.FAIL
              ? FontWeight.w700
              : FontWeight.normal,
          lableColor: controller.selectedTab.value == SelectTab.FAIL
              ? Colors.white
              : ColorConstants.black1,
          bgColor: controller.selectedTab.value == SelectTab.FAIL
              ? ColorConstants.black1
              : Colors.white,
          onClick: () {
            if (controller.selectedTab.value != SelectTab.FAIL) {
              controller.selectedTab.value = SelectTab.FAIL;
            }
          },
        ),
      ],
    );
  }

  _tab({text, lableColor, bgColor, onClick, weight}) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 40.0,
          color: bgColor,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: lableColor, fontSize: 16, fontWeight: weight),
            ),
          ),
        ),
      ),
    );
  }

  _bottomButtons(List<TaskDetails> items) {
    DriverHomeController homeController = Get.find<DriverHomeController>();
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: homeController.predeliveryIdsModel.value.result!.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Today\'s pre-delivery tasks already completed. Complete Delivery Tasks in Home Screen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorConstants.black1,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            fontFamily: FontFamilyConstants.firasansExtraBold),
                      ),
                    )
                  : Containers().loginButtonContainer(
                      color:
                          items.isEmpty ? Colors.grey : ColorConstants.color2,
                      text: items.isEmpty
                          ? 'Select items for Pre-Delivery'
                          : 'Proceed Pre-Delivery For Selected Items',
                      onClick: () {
                        items.isEmpty
                            ? SnackbarSupporter.showFailureSnackbar(
                                title: '',
                                message:
                                    'Please select atleast one task to proceed pre-delivery')
                            : controller.proceedForPreDeliveryConfirmation();
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

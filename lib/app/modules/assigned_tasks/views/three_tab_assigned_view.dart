import 'package:endura_app/app/data/model/assigned_schedules_list_model.dart';
import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:endura_app/core/utilities/date_utility.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ThreeTabAssignedView extends GetView<AssignedTasksController> {
  const ThreeTabAssignedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => controller.selectedTab.value == SelectTab.PENDING
            ? _bottomButtons()
            : const BottomAppBar(
                height: 0.0,
              ),
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
            _schedulesList(),
            //  _openTaskListWidget()
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _tab(
          text: 'TODOS',
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  _schedulesList() {
    List<TaskDetails> items = controller.selectedTab.value == SelectTab.FAIL
        ? controller.failTaskList.value
        : controller.selectedTab.value == SelectTab.PENDING
            ? controller.todosList.value
            : controller.completedList.value;

    return Expanded(
      child: controller.apiState.value == APIState.LOADING
          ? const LoaderView()
          : items.isNotEmpty
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
                          color: ColorConstants.color3),
                      child: InkWell(
                        onTap: () {
                          if (controller.selectedTab.value ==
                              SelectTab.PENDING) {
                            items[index].isCheckedForPreDelivery =
                                !items[index].isCheckedForPreDelivery;
                            controller.selectItem(items);
                          }
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.taskName!,
                                  style: TextStyle(
                                      color: ColorConstants.black1
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily:
                                          FontFamilyConstants.mulishExtraBold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Well: ${task.leaseLocation}",
                                  style: TextStyle(
                                      color: ColorConstants.black1
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily:
                                          FontFamilyConstants.mulishExtraBold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Location: ${task.location!.address}",
                                  style: TextStyle(
                                      color: ColorConstants.black1
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily:
                                          FontFamilyConstants.mulishExtraBold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Customer: ${task.customerName}",
                                  style: TextStyle(
                                      color: ColorConstants.black1
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontFamily:
                                          FontFamilyConstants.mulishExtraBold),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateUtility().getStartDateFormate(
                                          date: task.startDate),
                                      style: TextStyle(
                                          color: ColorConstants.black1
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          fontFamily: FontFamilyConstants
                                              .mulishExtraBold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                            const Spacer(),
                            controller.selectedTab.value == SelectTab.PENDING
                                ? _checkBox(
                                    icon: task.isCheckedForPreDelivery
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank)
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
  }

  _bottomButtons() {
    List<TaskDetails> items = controller.todosList.value
        .where((element) =>
            element.taskStatus == 'PENDING' && element.isCheckedForPreDelivery)
        .toList();
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Containers().loginButtonContainer(
                  color: items.isEmpty ? Colors.grey : ColorConstants.color2,
                  text: 'Proceed For Pre-Delivery',
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

  _checkBox({icon, onClick}) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 28,
        ),
      ),
    );
  }
}

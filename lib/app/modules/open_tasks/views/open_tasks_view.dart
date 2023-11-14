import 'package:fieldapp/app/data/model/open_tasks_list_model.dart';
import 'package:fieldapp/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:fieldapp/app/modules/open_tasks/controllers/open_tasks_controller.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/base_app_bar.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OpenTasksView extends GetView<OpenTasksController> {
  const OpenTasksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => _bottomButtons(
          controller.selectedTab.value == 'PAST'
              ? controller.pastTasks.value
                  .where((element) => element.isSelected!)
                  .toList()
              : controller.selectedTab.value == 'FUTURE'
                  ? controller.futureTasks.value
                      .where((element) => element.isSelected!)
                      .toList()
                  : controller.currentTasks.value
                      .where((element) => element.isSelected!)
                      .toList())),
      appBar: BaseAppBar(
        title: 'Open Tasks',
        hasBackButton: true,
        onBackButtonPressed: () {
          Get.back();
          Get.find<DriverHomeController>().getAllUserSchedules(
              Get.find<RoutesSelectorController>().selectedRouteName.value);
        },
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
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  controller.searchValue.value = value;
                },
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: FontFamilyConstants.firasans),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstants.black1.withOpacity(0.3),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding:
                      const EdgeInsets.only(left: 24, top: 28, bottom: 28),
                  hintText: 'Search By Company/Lease',
                  hintStyle: TextStyle(
                      color: ColorConstants.black1.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: FontFamilyConstants.firasans),
                ),
              ),
            ),
            Expanded(
                child: controller.apiState.value == APIState.LOADING
                    ? const LoaderView()
                    : _openTaskListWidget())
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
          text: 'PAST',
          weight: controller.selectedTab.value == 'PAST'
              ? FontWeight.w700
              : FontWeight.normal,
          lableColor: controller.selectedTab.value == 'PAST'
              ? Colors.white
              : ColorConstants.black1,
          bgColor: controller.selectedTab.value == 'PAST'
              ? ColorConstants.black1
              : Colors.white,
          onClick: () {
            if (controller.selectedTab.value != 'PAST') {
              controller.selectedTab.value = 'PAST';
            }
          },
        ),
        Container(
          height: 30.0,
          width: 1.0,
          color: ColorConstants.black1,
        ),
        _tab(
          text: 'TODAY\'S',
          weight: controller.selectedTab.value == 'CURRENT'
              ? FontWeight.w700
              : FontWeight.normal,
          lableColor: controller.selectedTab.value == 'CURRENT'
              ? Colors.white
              : ColorConstants.black1,
          bgColor: controller.selectedTab.value == 'CURRENT'
              ? ColorConstants.black1
              : Colors.white,
          onClick: () {
            if (controller.selectedTab.value != 'CURRENT') {
              controller.selectedTab.value = 'CURRENT';
            }
          },
        ),
        Container(
          height: 30.0,
          width: 1.0,
          color: ColorConstants.black1,
        ),
        _tab(
          text: 'FUTURE',
          weight: controller.selectedTab.value == 'FUTURE'
              ? FontWeight.w700
              : FontWeight.normal,
          lableColor: controller.selectedTab.value == 'FUTURE'
              ? Colors.white
              : ColorConstants.black1,
          bgColor: controller.selectedTab.value == 'FUTURE'
              ? ColorConstants.black1
              : Colors.white,
          onClick: () {
            if (controller.selectedTab.value != 'FUTURE') {
              controller.selectedTab.value = 'FUTURE';
            }
          },
        )
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

  Widget _openTaskListWidget() {
    List<OpenTask> items = [];
    if (controller.selectedTab.value == 'PAST') {
      for (var element in controller.pastTasks.value) {
        if (controller.searchValue.value.isEmpty) {
          items.add(element);
        } else if (element.leaseLocation!
                .toLowerCase()
                .contains(controller.searchValue.value.toLowerCase()) ||
            element.customerName!
                .toLowerCase()
                .contains(controller.searchValue.value.toLowerCase())) {
          items.add(element);
        }
      }
    } else if (controller.selectedTab.value == 'FUTURE') {
      for (var element in controller.futureTasks.value) {
        if (controller.searchValue.value.isEmpty) {
          items.add(element);
        } else if (element.leaseLocation!
                .toLowerCase()
                .contains(controller.searchValue.value.toLowerCase()) ||
            element.customerName!
                .toLowerCase()
                .contains(controller.searchValue.value.toLowerCase())) {
          items.add(element);
        }
      }
      // items.addAll(controller.futureTasks.value);
    } else {
      for (var element in controller.currentTasks.value) {
        if (controller.searchValue.value.isEmpty) {
          items.add(element);
        } else if (element.leaseLocation!
                .toLowerCase()
                .contains(controller.searchValue.value.toLowerCase()) ||
            element.customerName!
                .toLowerCase()
                .contains(controller.searchValue.value.toLowerCase())) {
          items.add(element);
        }
      }
      // items.addAll(controller.currentTasks.value);
    }

    return items.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              OpenTask _openTask = items[index];
              return _listItem(_openTask, index: index);
            })
        : Center(
            child: Text(
              controller.selectedTab.value == 'PAST'
                  ? "No Past Tasks Available"
                  : controller.selectedTab.value == 'CURRENT'
                      ? 'No Tasks Availble For Today'
                      : 'There Are No Tasks Available For Next\n30 Days',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorConstants.black1.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  fontFamily: FontFamilyConstants.mulishExtraBold),
            ),
          );
  }

  Widget _listItem(openTask, {index}) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 10, bottom: 15),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstants.color3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${openTask.taskName!} to ${openTask.leaseLocation} By ${openTask.customerName} Well on ${openTask.startDate.toString().substring(0, 10)}',
            style: TextStyle(
                color: ColorConstants.black1.withOpacity(0.7),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                fontFamily: FontFamilyConstants.mulishExtraBold),
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        controller.updateSelectedTasks(index: index);
                      },
                      child: Icon(!openTask.isSelected
                          ? Icons.check_box_outline_blank
                          : Icons.check_box_outlined)),
                  const Spacer(),
                  // InkWell(
                  //     onTap: () {
                  // Get.toNamed(Routes.WELL_DETAILS,
                  //     arguments: {'wellName': openTask.leaseLocation});
                  //     },
                  //     child: const Icon(
                  //       Icons.remove_red_eye,
                  //       color: ColorConstants.color2,
                  //     )),
                  // const SizedBox(
                  //   width: 10.0,
                  // ),
                  InkWell(
                    onTap: () {
                      controller.pickATask(
                          taskId: openTask.sId, taskName: openTask.taskName);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 5, right: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: ColorConstants.color2),
                      child: Text(
                        "Assign To Yourself",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.25,
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: FontFamilyConstants.firasansExtraBold,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      controller.viewTaskDetails(
                        openTask: openTask,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 5, right: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: ColorConstants.color2),
                      child: Text(
                        "View Task Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.25,
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: FontFamilyConstants.firasansExtraBold,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.WELL_DETAILS,
                          arguments: {'wellName': openTask.leaseLocation});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: ColorConstants.color2),
                      child: Text(
                        "View Well Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.25,
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: FontFamilyConstants.firasansExtraBold,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  _bottomButtons(List<OpenTask> items) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Containers().loginButtonContainer(
                  color: items.isEmpty ? Colors.grey : ColorConstants.color2,
                  text: items.isEmpty
                      ? 'Select tasks to assign to your self'
                      : 'Assign to your self',
                  onClick: () {
                    items.isEmpty
                        ? SnackbarSupporter.showFailureSnackbar(
                            title: '',
                            message:
                                'Please select atleast one task to Assign to your self')
                        : controller.doMultiSelectAPICall();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:endura_app/app/data/model/assigned_schedules_list_model.dart';
import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:endura_app/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/routes_search_select_view.dart';
import 'package:endura_app/app/modules/open_tasks/controllers/open_tasks_controller.dart';
import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/constants/image_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DriverHomeView extends GetView<DriverHomeController> {
  const DriverHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoutesSearchSelectView(onSelectRoute: (route) {
            controller.getAllUserSchedules(route);
          }),
          controller.apiState.value == APIState.COMPLETED
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTodaysTask(),
                    _buildOpenAndAsignedTasksWidget(),
                    _buildFormViewView(
                        title: 'Cumulative products for the day',
                        onClick: () {
                          controller.navigateTo(
                              route: Routes.CUMMULATIVE_PRODUCTS);
                        }),
                    _buildDelivery(),
                  ],
                )
              : _getShimmerLoader()
        ],
      ),
    ));
  }

  Widget _buildDelivery() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery",
            style: TextStyle(
                color: ColorConstants.black1.withOpacity(0.5),
                fontWeight: FontWeight.w700,
                fontSize: 14,
                fontFamily: FontFamilyConstants.firasansMedium),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: InkWell(
              onTap: () {
                if (controller.preDeliveryIds.value.isEmpty) {
                  SnackbarSupporter.showFailureSnackbar(
                      title: '',
                      message: 'Complete Predelivery for today\'s Tasks');
                } else {
                  Get.toNamed(Routes.DURING_DELIVERY_TASKS_LIST);
                }
              },
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 24.0,
                    ),
                    SvgPicture.asset(
                      ImageConstants.calender1,
                      height: 36,
                      width: 36,
                      color: controller
                              .predeliveryIdsModel.value.result!.isNotEmpty
                          ? ColorConstants.black1
                          : Colors.white,
                    ),
                    const SizedBox(
                      width: 24.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Tasks',
                          style: TextStyle(
                              color: controller.predeliveryIdsModel.value
                                      .result!.isNotEmpty
                                  ? ColorConstants.black1
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              fontFamily:
                                  FontFamilyConstants.firasansExtraBold),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
                color: controller.predeliveryIdsModel.value.result!.isNotEmpty
                    ? Colors.white
                    : const Color.fromARGB(255, 184, 183, 183),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: const Color.fromRGBO(117, 25, 3, 0.13))),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFormViewView({title, onClick}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(117, 25, 3, 0.1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.box, height: 24, width: 24),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      fontFamily: FontFamilyConstants.firasansExtraBold),
                ),
              ),
              const Spacer(),
              Center(child: SvgPicture.asset(ImageConstants.rightArrow)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleItem({title, subTitle, onClick}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: InkWell(
        onTap: onClick,
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 24.0,
              ),
              SvgPicture.asset(ImageConstants.calender1, height: 36, width: 36),
              const SizedBox(
                width: 24.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: ColorConstants.black1,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        fontFamily: FontFamilyConstants.firasansExtraBold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.black1.withOpacity(0.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        fontFamily: FontFamilyConstants.firasans),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color.fromRGBO(117, 25, 3, 0.13))),
    );
  }

  Widget _buildOpenAndAsignedTasksWidget() {
    RoutesSelectorController selectorController =
        Get.find<RoutesSelectorController>();
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          _scheduleItem(
              title: selectorController.selectedRouteName.value ==
                      'Select Route'
                  ? 'Select Route For Open Tasks'
                  : '${selectorController.selectedRouteName.value} Open Tasks',
              subTitle: 'Pick a Task',
              onClick: () {
                Get.find<OpenTasksController>().getOpenTasks();
                controller.navigateTo(route: Routes.OPEN_TASKS);
              }),
          const SizedBox(
            height: 12.0,
          ),
          _scheduleItem(
              title: selectorController.selectedRouteName.value ==
                      'Select Route'
                  ? 'Select Route For Assign Tasks'
                  : '${selectorController.selectedRouteName.value} Assigned Tasks',
              subTitle: 'View Your Tasks',
              onClick: () {
                print('ASSIGNED');
                controller.navigateTo(route: Routes.ASSIGNED_TASKS);
              })
        ],
      ),
    );
  }

  _buildTodaysTask() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.only(
            top: 12, left: 14.0, right: 14.0, bottom: 12.0),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(117, 25, 3, 0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageConstants.calender,
                    height: 24, width: 24),
                const SizedBox(width: 11),
                Text(
                  'Pending Tasks For Today',
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      fontFamily: FontFamilyConstants.firasansExtraBold),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      controller.expandTodaysTasks.value =
                          !controller.expandTodaysTasks.value;
                    },
                    child: Icon(
                      controller.expandTodaysTasks.value
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 36.0,
                    )),
              ],
            ),
            if (controller.expandTodaysTasks.value)
              _todaysTaskItems()
            else
              const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _todaysTaskItems() {
    AssignedTasksController _assignedTasksController =
        Get.find<AssignedTasksController>();
    RoutesSelectorController selectorController =
        Get.find<RoutesSelectorController>();

    List pendingTasks = _assignedTasksController.todosList.value;
    return controller.predeliveryIdsModel.value.result!.isNotEmpty
        ? Text(
            'Today\'s pre-delivery tasks already completed. Proceed to Delivery Tasks Below',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorConstants.black1,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                fontFamily: FontFamilyConstants.firasansExtraBold),
          )
        : (selectorController.selectedRouteName.value == 'Select Route')
            ? Text(
                'Select route view today\'s tasks',
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    fontFamily: FontFamilyConstants.firasansExtraBold),
              )
            : (_assignedTasksController.todosList.value.isEmpty)
                ? Text(
                    'No Pending Task\'s Available', // "Service Report",
                    style: TextStyle(
                        color: ColorConstants.black1,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        fontFamily: FontFamilyConstants.firasansExtraBold),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              pendingTasks.length > 3 ? 3 : pendingTasks.length,
                          itemBuilder: (context, index) {
                            TaskDetails task =
                                _assignedTasksController.todosList.value[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      const Color.fromARGB(204, 255, 113, 5)),
                              child: InkWell(
                                onTap: () {
                                  _assignedTasksController.viewTaskDetails(
                                      openTask: task,
                                      showActionButton: true,
                                      action: () {
                                        _assignedTasksController
                                                .todosList
                                                .value[index]
                                                .isCheckedForPreDelivery =
                                            !_assignedTasksController
                                                .todosList
                                                .value[index]
                                                .isCheckedForPreDelivery;
                                        _assignedTasksController.selectItem(
                                            _assignedTasksController
                                                .todosList.value);
                                        Get.back();
                                      });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${task.taskName!} to ${task.leaseLocation} Well on ${task.startDate.toString().substring(0, 10)}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                fontFamily:
                                                    FontFamilyConstants
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
                                                fontFamily:
                                                    FontFamilyConstants
                                                        .mulishExtraBold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          _assignedTasksController
                                                  .todosList
                                                  .value[index]
                                                  .isCheckedForPreDelivery =
                                              !_assignedTasksController
                                                  .todosList
                                                  .value[index]
                                                  .isCheckedForPreDelivery;
                                          _assignedTasksController.selectItem(
                                              _assignedTasksController
                                                  .todosList.value);
                                        },
                                        child: _checkBox(
                                            icon: task.isCheckedForPreDelivery
                                                ? Icons.check_box
                                                : Icons
                                                    .check_box_outline_blank))
                                  ],
                                ),
                              ),
                            );
                          }),
                      _assignedTasksController.todosList.value.length > 3
                          ? _viewMoreItems()
                          : _bottomButtons(_assignedTasksController
                              .todosList.value
                              .where((element) =>
                                  element.taskStatus!.toLowerCase() ==
                                      'pending' &&
                                  element.isCheckedForPreDelivery)
                              .toList())
                    ],
                  );
  }

  _bottomButtons(List<TaskDetails> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Containers().loginButtonContainer(
                color: items.isEmpty ? Colors.grey : ColorConstants.color2,
                text: items.isEmpty
                    ? 'Select items for Pre-Delivery'
                    : 'Proceed Pre-Delivery For Selected Items',
                onClick: () {
                  if (items.isEmpty) {
                    SnackbarSupporter.showFailureSnackbar(
                        title: '',
                        message:
                            'Please select atleast one task to proceed pre-delivery');
                  } else {
                    AssignedTasksController _assignedTasksController =
                        Get.find<AssignedTasksController>();
                    _assignedTasksController
                        .proceedForPreDeliveryConfirmation();
                  }
                }),
          ),
        ],
      ),
    );
  }

  _viewMoreItems() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Containers().loginButtonContainer(
                color: ColorConstants.color2,
                text: 'View More Items',
                onClick: () {
                  Get.find<AssignedTasksController>().selectedTab.value =
                      SelectTab.PENDING;
                  Get.toNamed(Routes.ASSIGNED_TASKS);
                  // _as.proceedForPreDeliveryConfirmation(
                  //     items: items);
                }),
          ),
        ],
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
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  _getShimmerLoader() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (conext, index) {
        return Shimmer.fromColors(
          baseColor: ColorConstants.color2.withOpacity(0.05),
          highlightColor: ColorConstants.black1.withOpacity(0.2),
          child: Container(
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            height: 120.0,
            width: double.infinity,
          ),
        );
      },
    );
  }
}

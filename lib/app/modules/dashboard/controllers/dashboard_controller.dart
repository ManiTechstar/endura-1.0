import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:endura_app/app/modules/login/controllers/login_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final currentIndex = 0.obs;

  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    if (Get.find<LoginController>().userModel.value.role == 'Truck Driver') {
      Get.find<RoutesSelectorController>().getAllRoutes();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  updateIndex(index) {
    currentIndex(index);
    // RoutesSelectorController routesSelectorController =
    //     Get.find<RoutesSelectorController>();
    // if (index == 1) {
    //   if (routesSelectorController.selectedRouteName.value != 'Select Route') {
    //     Get.find<AssignedTasksController>().getUserTasks();

    //     currentIndex(index);
    //   } else {
    //     SnackbarSupporter.showFailureSnackbar(
    //         title: 'Error', message: 'Please Select Route');
    //   }
    // } else {

    // }
  }
}

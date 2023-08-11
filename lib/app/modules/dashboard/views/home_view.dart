import 'package:endura_app/app/modules/dashboard/controllers/service_tech_home_controller.dart';
import 'package:endura_app/app/modules/dashboard/views/driver_home_view.dart';
import 'package:endura_app/app/modules/dashboard/views/managers_home_view.dart';
import 'package:endura_app/app/modules/dashboard/views/service_tech_home/service_tech_home_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:endura_app/app/modules/login/controllers/login_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/utilities/date_utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userData = Get.find<LoginController>();

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Hello, ${userData.userModel.value.name!}',
        hasBackButton: false,
        actions: [
          InkWell(
            onTap: () async {
              print('Refresh clicked');
              String? role = Get.find<LoginController>().userModel.value.role;
              if (role == 'Truck Driver') {
                Get.find<RoutesSelectorController>().getAllRoutes();
              } else if (role == 'Service Tech' || role == 'Delivery Driver') {
                print('Service Tech');
                Get.find<ServiceTechHomeController>().resetUI();
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.refresh,
                size: 27,
                color: Colors.brown,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 6.0),
              child: Text(
                "Today | " + DateUtility().getDashboardDate(),
                style: TextStyle(
                    color: ColorConstants.black1.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    fontFamily: FontFamilyConstants.firasans),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: userData.userModel.value.role == 'Service Tech' ||
                          userData.userModel.value.role == 'Delivery Driver'
                      ? const ServiceTechHomeView()
                      : userData.userModel.value.role == 'Truck Driver'
                          ? const DriverHomeView()
                          : const ManagersHomeView()),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';

import 'package:endura_app/app/data/model/user_model.dart';
import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:endura_app/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:endura_app/app/modules/dashboard/controllers/service_tech_home_controller.dart';
import 'package:endura_app/app/modules/dashboard/controllers/service_tech_lease_products_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/account_representative_selector_controller.dart';

import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';

import 'package:endura_app/app/modules/dropdown_selector/controllers/service_tech_home_company_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/service_tech_home_lease_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/service_tech_home_representative_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/warehouse_selector_controller.dart';
import 'package:endura_app/app/modules/login/controllers/login_controller.dart';
import 'package:endura_app/app/modules/open_tasks/controllers/open_tasks_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    UserModel model = Get.find<LoginController>().userModel.value;

    if (model.role == 'Truck Driver') {
      Get.lazyPut<DashboardController>(
        () => DashboardController(),
      );

      Get.put<DriverHomeController>(
        DriverHomeController(),
      );

      Get.put<DriverHomeController>(
        DriverHomeController(),
      );

      Get.put<RoutesSelectorController>(
        RoutesSelectorController(),
      );

      Get.put<OpenTasksController>(
        OpenTasksController(),
      );
      Get.put<AssignedTasksController>(
        AssignedTasksController(),
      );
    } else if (model.role == 'Service Tech' ||
        model.role == 'Delivery Driver') {
      Get.put(
        DashboardController(),
      );

      Get.put<ServiceTechHomeRepresentativeSelectorController>(
        ServiceTechHomeRepresentativeSelectorController(),
      );
      Get.put<ServiceTechCompanySelectorController>(
        ServiceTechCompanySelectorController(),
      );

      Get.put<ServiceTechHomeFormLeaseSelectorController>(
        ServiceTechHomeFormLeaseSelectorController(),
      );

      Get.lazyPut<ServiceTechHomeController>(
        () => ServiceTechHomeController(),
      );

      initGet();
      // Analysis form
    } else {
      Get.put(
        DashboardController(),
      );

      initGet();
    }
// service tech home
  }

  void initGet() {
    Get.put<AccountRepresentativeSelectorController>(
      AccountRepresentativeSelectorController(),
    );

    Get.put(
      WarehouseSelectorController(),
    );

    Get.put<ServiceTechLeaseProductsController>(
      ServiceTechLeaseProductsController(),
    );

  }
}

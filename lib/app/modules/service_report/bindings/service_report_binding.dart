import 'package:endura_app/app/modules/dropdown_selector/controllers/service_report_company_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/service_report_lease_selector_controller.dart';
import 'package:get/get.dart';

import '../controllers/service_report_controller.dart';

class ServiceReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ServiceReportController>(
      ServiceReportController(),
    );

    Get.put<ServiceReportCompanySelectorController>(
        ServiceReportCompanySelectorController());

    Get.put<ServiceReportLeaseSelectorController>(
        ServiceReportLeaseSelectorController());
  }
}

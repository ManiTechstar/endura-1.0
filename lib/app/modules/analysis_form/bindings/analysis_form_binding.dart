import 'package:fieldapp/app/modules/dropdown_selector/controllers/analysis_form_company_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/analysis_form_lease_selector_controller.dart';
import 'package:get/get.dart';

import '../controllers/analysis_form_controller.dart';

class AnalysisFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisFormController>(
      () => AnalysisFormController(),
    );
    Get.put<AnalysisFormCompanySelectorController>(
        AnalysisFormCompanySelectorController());

    Get.put<AnalysisFormLeaseSelectorController>(
        AnalysisFormLeaseSelectorController());
  }
}

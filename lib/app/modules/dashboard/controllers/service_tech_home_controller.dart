import 'package:fieldapp/app/data/model/products_by_well_model.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_tech_home_company_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_tech_home_lease_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_tech_home_representative_selector_controller.dart';
import 'package:fieldapp/app/providers/service_tech_provider.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';

import 'package:get/get.dart';

class ServiceTechHomeController extends BaseController {
  late ServiceTechHomeRepresentativeSelectorController
      serviceTechHomeRepresentativeSelectorController;

  var serviceReport = 'Service Report'.obs;

  @override
  void onInit() {
    serviceTechHomeRepresentativeSelectorController =
        Get.find<ServiceTechHomeRepresentativeSelectorController>();
    super.onInit();
  }

  serviceTechTargetApi(
    List<Products> updatedProducts,
  ) async {
    apiState.value = APIState.LOADING;
    ServiceTechHomeFormLeaseSelectorController
        serviceTechHomeFormLeaseSelectorController =
        Get.find<ServiceTechHomeFormLeaseSelectorController>();

    String message =
        await ServiceTechProvider().serviceTechTargetInjectApi(params: {
      "well_id":
          serviceTechHomeFormLeaseSelectorController.selectedWellId.value,
      "products": updatedProducts
    });

    SnackbarSupporter.showSuccessSnackbar(title: 'Injuction', message: message);

    resetUI();
    apiState.value = APIState.COMPLETED;
  }

  void resetUI() {
    Get.find<ServiceTechHomeFormLeaseSelectorController>()
        .selectedLeaseName
        .value = 'Select Lease';

    // Get.find<ServiceTechCompanySelectorController>().selectedCompanyName.value =
    //     'Select Company';

    // Get.find<ServiceTechHomeRepresentativeSelectorController>()
    //     .selectedRepresentativeName
    //     .value = 'Select Representative';
  }
}

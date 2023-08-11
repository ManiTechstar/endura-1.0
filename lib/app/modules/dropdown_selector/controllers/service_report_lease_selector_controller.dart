import 'package:endura_app/app/data/model/leases_model.dart';

import 'package:endura_app/app/providers/dropdown_selector_service_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class ServiceReportLeaseSelectorController extends BaseController {
  var model = LeasesModel().obs;
  var selectedLeaseName = 'Select Lease'.obs;
  var routes = <String>[].obs;
  @override
  void onInit() {
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

  void setLeaseName({name}) {
    selectedLeaseName.value = name;
  }

  void _setValuesToList() {
    List<String> names = [];
    for (int i = 0; i < model.value.result!.length; i++) {
      names.add(model.value.result![i].location!);
    }
    routes.value = names;
  }

  void getLocationsByCustomerId({customerId}) async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        model.value = await DropdownSelectorServiceProvider()
            .getAllLocationsByCustomerId(customerId: customerId);
        _setValuesToList();
        // Get.find<ServiceReportController>().clearAll();
        selectedLeaseName.value = 'Select Lease';
        apiState.value = APIState.COMPLETED;
      } catch (e) {
        apiState.value = APIState.COMPLETED;
        SnackbarSupporter.showFailureSnackbar(title: 'Error', message: '');
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Connectivity Exception',
          message: 'Please check your network');
    }
  }
}

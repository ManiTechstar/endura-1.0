import 'package:endura_app/app/data/model/service_tech_home_lease_model.dart';

import 'package:endura_app/app/providers/dropdown_selector_service_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class ServiceTechHomeFormLeaseSelectorController extends BaseController {
  var model = ServiceTechHomeLeaseModel().obs;
  var selectedLeaseName = 'Select Lease'.obs;
  var selectedWellId = ''.obs;
  var wells = <String>[].obs;

  void setLeaseName({name}) {
    selectedLeaseName.value = name;
  }

  void _setValuesToList() {
    List<String> names = [];
    for (int i = 0; i < model.value.result!.length; i++) {
      names.add(model.value.result![i].location!);
    }
    wells.value = names;
  }

  void getAllWellsByCustomer({email, accRepEmail, customerId}) async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        model.value = await DropdownSelectorServiceProvider()
            .getAllWellsByCustomer(
                email: email, accRepEmail: accRepEmail, customerId: customerId);
        _setValuesToList();
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

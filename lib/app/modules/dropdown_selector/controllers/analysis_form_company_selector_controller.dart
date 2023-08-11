import 'package:endura_app/app/data/model/analysis_form_customer_list_model.dart';
import 'package:endura_app/app/providers/dropdown_selector_service_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class AnalysisFormCompanySelectorController extends BaseController {
  var model = AnalysisFormCustomerListModel().obs;
  var selectedCompanyName = 'Select Company'.obs;
  var companies = <String>[].obs;

  void setCompanyName({name}) {
    selectedCompanyName.value = name;
  }

  void _setValuesToList() {
    List<String> names = [];
    for (int i = 0; i < model.value.result!.length; i++) {
      if ((model.value.result![i].customerId!.isNotEmpty &&
              model.value.result![i].customerName!.isNotEmpty) &&
          !names.contains(model.value.result![i].customerName)) {
        names.add(model.value.result![i].customerName!);
      }
    }
    companies.value = names;
  }

  Future<void> getCustomersOrCompaniesByRepId({id}) async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        model.value = await DropdownSelectorServiceProvider()
            .getCompaniesOrCustomersByRepresentative(id: id);
        _setValuesToList();

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

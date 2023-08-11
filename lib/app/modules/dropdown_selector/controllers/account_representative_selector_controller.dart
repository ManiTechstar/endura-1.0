import 'package:endura_app/app/data/model/account_representative_list_model.dart';
import 'package:endura_app/app/data/model/route_list_model.dart';
import 'package:endura_app/app/providers/dropdown_selector_service_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class AccountRepresentativeSelectorController extends BaseController {
  var model = AccountRepresentativeListModel().obs;
  var selectedRepresentativeName = 'Select Representative'.obs;
  var selectedRepresentativeId = '';
  var routes = <String>[].obs;
  @override
  void onInit() {
    // getAllRepresentative();
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

  void setRepresentativeName({name}) {
    selectedRepresentativeName.value = name;
    
  }

  void _setValuesToList() {
    List<String> names = [];
    for (int i = 0; i < model.value.result!.length; i++) {
      names.add(model.value.result![i].name!);
    }
    routes.value = names;
  }

  void getAllRepresentative() async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        selectedRepresentativeName.value = 'Select Representative';
        model.value =
            await DropdownSelectorServiceProvider().getAllRepresentatives();
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

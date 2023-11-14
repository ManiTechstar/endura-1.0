import 'package:fieldapp/app/data/model/account_representative_list_model.dart';
import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/providers/dropdown_selector_service_provider.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class ServiceTechHomeRepresentativeSelectorController extends BaseController {
  var model = AccountRepresentativeListModel().obs;
  var selectedRepresentativeName = 'Select Representative'.obs;
  var selectedRepresentativeEmail = ''.obs;
  var routes = <String>[].obs;
  @override
  void onInit() {
    getAllRepresentative();
    super.onInit();
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
        model.value = await DropdownSelectorServiceProvider()
            .getAllAccountRepresentativesOrManagers(
                email: Get.find<LoginController>().userModel.value.email);
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

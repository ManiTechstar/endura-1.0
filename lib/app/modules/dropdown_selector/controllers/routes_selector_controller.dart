import 'package:fieldapp/app/data/model/route_list_model.dart';

import 'package:fieldapp/app/providers/dropdown_selector_service_provider.dart';

import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class RoutesSelectorController extends BaseController {
  var models = RouteListModel().obs;
  var selectedRouteName = 'Select Route'.obs;
  var routes = <String>[].obs;
  @override
  void onInit() {
    // getAllRoutes();
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

  void _setValuesToList() {
    List<String> names = [];
    for (int i = 0; i < models.value.routes!.length; i++) {
      names.add(models.value.routes![i].routes!);
    }
    routes.value = names;
  }

  void getAllRoutes() async {
    selectedRouteName.value = 'Select Route';

    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        models.value = await DropdownSelectorServiceProvider().getAllRoutes();
        _setValuesToList();
        apiState.value = APIState.COMPLETED;
      } catch (e) {
        apiState.value = APIState.COMPLETED;
        SnackbarSupporter.showFailureSnackbar(title: 'Error', message: e);
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Connectivity Exception',
          message: 'Please check your network');
    }
  }
}

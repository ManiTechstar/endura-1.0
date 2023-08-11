import 'package:endura_app/app/data/model/warehouse_model.dart';
import 'package:endura_app/app/providers/dropdown_selector_service_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class WarehouseSelectorController extends BaseController {
  var models = WarehoseModel().obs;
  var selectedWarehouseName = 'Select Warehouse'.obs;
  var routes = <String>[].obs;
  @override
  void onInit() {
    getAllWarehouses();
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

  void setWarehouseName({name}) {
    selectedWarehouseName.value = name;
  }

  void _setValuesToList() {
    List<String> names = [];
    for (int i = 0; i < models.value.result!.length; i++) {
      names.add(models.value.result![i].warehouse!);
    }
    routes.value = names;
  }

  void getAllWarehouses() async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        models.value = await DropdownSelectorServiceProvider().getAllWarehouses();
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

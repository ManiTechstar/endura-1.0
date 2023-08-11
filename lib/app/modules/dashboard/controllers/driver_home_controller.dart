import 'package:endura_app/app/data/model/predelivery_ids_model.dart';
import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:endura_app/app/modules/login/controllers/login_controller.dart';
import 'package:endura_app/app/providers/predelivery_service_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class DriverHomeController extends BaseController {
  late RxList preDeliveryIds = [].obs;

  late Rx<PredeliveryIdsModel> predeliveryIdsModel;
  RxBool expandTodaysTasks = false.obs;

  RxBool enableDuringDelivery = false.obs;

  @override
  void onInit() {
    predeliveryIdsModel = Rx(PredeliveryIdsModel());
    if (Get.find<LoginController>().userModel.value.role == 'Truck Driver') {
      getTodayPredeliveryStatus();
    }

    super.onInit();
  }

  getTodayPredeliveryStatus() async {
    apiState.value = APIState.LOADING;
    preDeliveryIds.value = [];
    predeliveryIdsModel.value = await PredeliveryServiceProvider()
        .todayPredeliveryStatus(
            email: Get.find<LoginController>().userModel.value.email!);

    preDeliveryIds.value = predeliveryIdsModel.value.result!;

    apiState.value = APIState.COMPLETED;
  }

  void navigateTo({route}) async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      if (Get.find<RoutesSelectorController>().selectedRouteName.value !=
          'Select Route') {
        Get.toNamed(route);
      } else {
        SnackbarSupporter.showFailureSnackbar(
            title: 'Route', message: 'Please Select Route');
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Connectivity Exception',
          message: 'Please check your network');
    }
  }

  void getAllUserSchedules(String route) async {
    apiState.value = APIState.LOADING;
    expandTodaysTasks.value = false;
    await Get.find<AssignedTasksController>().getUserTasks();
    apiState.value = APIState.COMPLETED;
  }
}

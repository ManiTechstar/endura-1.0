import 'package:fieldapp/app/data/model/during_delivery_task_model.dart';
import 'package:fieldapp/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:fieldapp/app/providers/during_delivery_service_provider.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:get/get.dart';

class DuringDeliveryTasksListController extends BaseController {
  late Rx<DuringDeliveryTaskModel> model;
  late Rx<String> selectedTaskId;
  @override
  void onInit() {
    model = Rx.new(DuringDeliveryTaskModel());
    selectedTaskId = Rx.new('');
    getDuringDeliveryTasks();
    super.onInit();
  }

  getDuringDeliveryTasks() async {
    apiState.value = APIState.LOADING;
    DriverHomeController homeController = Get.find<DriverHomeController>();
    model.value = await DuringdeliveryServiceProvider().getTaskDetails(
        params: {'task_ids': homeController.preDeliveryIds.value});
    apiState.value = APIState.COMPLETED;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

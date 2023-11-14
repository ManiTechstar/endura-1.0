import 'package:fieldapp/app/data/model/delivery_steps_model.dart';
import 'package:fieldapp/app/modules/during_delivery_tasks_list/controllers/during_delivery_tasks_list_controller.dart';
import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/providers/during_delivery_service_provider.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class DuringDeliveryController extends BaseController {
  final count = 0.obs;
  final status = 'Status'.obs;

  late Rx<DeliverStepsyModel> deliveryModel;
  late Rx<List<bool>> selectedSteps;

  getDeliverySteps() async {
    selectedSteps.value = [];
    try {
      apiState.value = APIState.LOADING;
      deliveryModel.value = await DuringdeliveryServiceProvider()
          .getDuringDeliverySteps(
              taskId: Get.find<DuringDeliveryTasksListController>()
                  .selectedTaskId
                  .value);
      for (int x = 0;
          x < deliveryModel.value.result!.subTaskSteps.length;
          x++) {
        selectedSteps.value.add(false);
      }

      apiState.value = APIState.COMPLETED;
    } catch (e) {
      apiState.value = APIState.COMPLETED;
    }
  }

  @override
  void onInit() {
    deliveryModel = Rx(DeliverStepsyModel());
    selectedSteps = Rx([]);
    getDeliverySteps();
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

  void increment() => count.value++;

  void selectedStatus(item) {
    status.value = item;
  }

  void completeTask() async {
    apiState.value = APIState.LOADING;
    String message =
        await DuringdeliveryServiceProvider().completeTask(params: {
      "task_id":
          Get.find<DuringDeliveryTasksListController>().selectedTaskId.value,
      "user_email": Get.find<LoginController>().userModel.value.email,
      "status": status.value
    });
    SnackbarSupporter.showSuccessSnackbar(title: 'Delivery', message: message);
    apiState.value = APIState.COMPLETED;
    Get.find<DuringDeliveryTasksListController>().getDuringDeliveryTasks();
    Get.offNamed(Routes.DURING_DELIVERY_TASKS_LIST);
  }

  void updateSelectiveSteps(selectedItems) {
    selectedSteps.value = [];
    selectedSteps.value = selectedItems;
  }
}

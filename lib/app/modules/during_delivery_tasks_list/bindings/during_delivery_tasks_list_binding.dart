import 'package:endura_app/app/modules/assigned_tasks/controllers/assigned_tasks_controller.dart';
import 'package:get/get.dart';

import '../controllers/during_delivery_tasks_list_controller.dart';

class DuringDeliveryTasksListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DuringDeliveryTasksListController>(
      () => DuringDeliveryTasksListController(),
    );
    Get.lazyPut<AssignedTasksController>(
      () => AssignedTasksController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/predelivery_controller.dart';

class PredeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PredeliveryController>(
      () => PredeliveryController(),
    );
  }
}

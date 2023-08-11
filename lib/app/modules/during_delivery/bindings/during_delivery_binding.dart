import 'package:get/get.dart';

import '../controllers/during_delivery_controller.dart';

class DuringDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DuringDeliveryController>(
      () => DuringDeliveryController(),
    );
    
  }
}

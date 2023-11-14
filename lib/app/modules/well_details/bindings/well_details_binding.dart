import 'package:get/get.dart';

import '../controllers/well_details_controller.dart';

class WellDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WellDetailsController>(
      () => WellDetailsController(),
    );
  }
}

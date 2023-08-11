import 'package:get/get.dart';

import '../controllers/cummulative_products_controller.dart';

class CummulativeProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CumulativeProductsController>(
      () => CumulativeProductsController(),
    );
  }
}

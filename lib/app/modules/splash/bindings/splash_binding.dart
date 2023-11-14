import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(),
    );
    Get.put<LoginController>(
      LoginController(),
    );
  }
}

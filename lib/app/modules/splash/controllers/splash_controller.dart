import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/utilities/shared_preferance_helper.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _checkLoginSession();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _checkLoginSession() async {
    var user = await SharedPreferanceHelper().getSharedPrefString(key: 'user');

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (user != null && user.isNotEmpty) {
        Get.offNamed(Routes.DASHBOARD);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}

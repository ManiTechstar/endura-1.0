import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/utilities/shared_preferance_helper.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
      installerStore: 'Unknown',
    );

    print("PACKAGE NAME ==> ${_packageInfo.packageName}");
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

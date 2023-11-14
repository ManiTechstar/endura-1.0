import 'package:fieldapp/app/data/model/cumulative_products_model.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/providers/cumulatives_service_provider.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class CumulativeProductsController extends BaseController {
  Rx<CumulativeProductsModel> cumulativeProductsModel =
      CumulativeProductsModel().obs;
  @override
  void onInit() {
    _getCumulativeProducts();
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

  _getCumulativeProducts() async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        RoutesSelectorController routesSelectorController =
            Get.find<RoutesSelectorController>();

        CumulativeProductsModel model = await CumulativesServiceProvider()
            .getCumulativeProducts(
                routeName: routesSelectorController.selectedRouteName.value,
                email: Get.find<LoginController>().userModel.value.email);

        cumulativeProductsModel.value = model;
        apiState.value = APIState.COMPLETED;
      } catch (e) {
        apiState.value = APIState.COMPLETED;
        SnackbarSupporter.showFailureSnackbar(title: '', message: e.toString());
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Connectivity Exception',
          message: 'Please check your network');
    }
  }
}

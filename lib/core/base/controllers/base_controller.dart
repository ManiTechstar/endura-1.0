import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum APIState { NONE, LOADING, COMPLETED }

abstract class BaseController extends GetxController {
  Rx<APIState> apiState = APIState.NONE.obs;

  var isInternetConnected = false.obs;
  Future<void> checkInternetConnectivity() async {
    isInternetConnected(await InternetConnectionChecker().hasConnection);
  }

  Future<bool> isInternetAvailable() async {
    bool result = await InternetConnectionChecker().hasConnection;
    isInternetConnected(result);
    return result;
  }
}

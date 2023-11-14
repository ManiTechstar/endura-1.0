import 'package:fieldapp/app/data/model/get_wel_lat_long_model.dart';
import 'package:fieldapp/app/providers/well_details_provider.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/dialogs/views/action_dialog_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

class WellDetailsController extends BaseController {
  final count = 0.obs;
  var welName = ''.obs;
  var latLongModel = GetWelLatLongModel().obs;
  late Position currentLocation;
  @override
  void onInit() {
    welName.value = Get.arguments['wellName'];

    getWelLocation();
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

  void increment() => count.value++;

  void pickATask() {
    Get.dialog(ActionDialogView(
      yesButtonText: 'Update',
      title: 'Warning',
      noButtonText: 'Cancel',
      message:
          'Updating GPS Location! This will OVERWRITE the coordinates of Well Name - $welName to your current position.',
      yesAction: () {
        Get.back();
        getCurrentLocationAndSendToApi();
      },
      noAction: () {
        Get.back();
      },
    ));
  }

  getCurrentLocationAndSendToApi() async {
    currentLocation = await readCurrentLocation();
    setWelLocation(
        lat: currentLocation.latitude, long: currentLocation.longitude);
    print(currentLocation.latitude);
    print(currentLocation.longitude);
  }

  Future<void> getWelLocation() async {
    apiState.value = APIState.LOADING;
    try {
      latLongModel.value = await WellDetailsProvider()
          .getLatLongsForWell(params: {'location': welName.value});
      apiState.value = APIState.COMPLETED;
    } catch (e) {
      apiState.value = APIState.COMPLETED;
    }
  }

  Future<void> launchGoogleMaps() async {
    MapsLauncher.launchCoordinates(latLongModel.value.result![0],
        latLongModel.value.result![1], '$welName Location');
  }

  Future<void> setWelLocation({lat, long}) async {
    apiState.value = APIState.LOADING;
    try {
      await WellDetailsProvider().updateLatLongsForWell(
          params: {"location": welName.value, "lat": lat, "long": long});
      getWelLocation();
    } catch (e) {
      apiState.value = APIState.COMPLETED;
    }
  }

  Future<Position> readCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Enable Location Permission');
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    if (locationPermission == LocationPermission.denied) {
      return Future.error('Enable Location Permission');
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permision Denied Forever, Please Go to settings and Enable The Permission');
    }

    return await Geolocator.getCurrentPosition();
  }
}

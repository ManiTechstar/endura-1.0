import 'package:endura_app/app/data/model/predelivery_steps_model.dart';
import 'package:endura_app/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:endura_app/app/providers/predelivery_service_provider.dart';
import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/dialogs/views/action_dialog_view.dart';
import 'package:endura_app/core/dialogs/views/load_product_dialog_view.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';

class PredeliveryController extends BaseController {
  final expandedIndex = 8080.obs;
  late Rx<PredeliveryStepsModel> predeliveryStepsModel;
  late Rx<List<SubTaskSteps>> subTaskSteps;
  late Rx<List<Products>> productsToLoad;
  late Rx<InspectionSteps> inspectionSteps;

  final isSubTaskUpdate = false.obs;

  _getPredeliverySteps() async {
    apiState.value = APIState.LOADING;
    DriverHomeController homeController = Get.find<DriverHomeController>();
    predeliveryStepsModel.value = await PredeliveryServiceProvider()
        .getPredeliverySelectiveSteps(
            params: {"task_ids": homeController.preDeliveryIds.value});
    productsToLoad.value = [];
    List<Products> finalList = [];

    for (Result result in predeliveryStepsModel.value.result!) {
      subTaskSteps.value = [];
      subTaskSteps.value = result.subsTasks![0].subTaskSteps!;
      for (int i = 0; i < result.subsTasks![0].subTaskSteps!.length; i++) {
        SubTaskSteps element = result.subsTasks![0].subTaskSteps![i];
        if (expandedIndex.value == 8080) {
          if (element.stepStatus == 'pending') {
            expandedIndex.value = i;
          } else if (element.stepStatus == 'completed' &&
              i == result.subsTasks![0].subTaskSteps!.length - 1) {
            expandedIndex.value = i;
          }
        }
        if (element.products != null && element.products!.isNotEmpty) {
          List<Products> list = element.products!;

          for (int x = 0; x < list.length; x++) {
            if (finalList.isEmpty) {
              finalList.add(list[x]);
            } else {
              for (int i = 0; i < finalList.length; i++) {
                if (finalList[i].productId == list[x].productId) {
                  finalList[i].uomGal =
                      '${double.parse(finalList[i].uomGal!) + double.parse(list[x].uomGal!)}';
                  break;
                } else {
                  List items = finalList
                      .where(
                          (element) => element.productId == list[x].productId)
                      .toList();
                  if (items.isEmpty) {
                    finalList.add(list[x]);
                    break;
                  }
                }
              }
            }
          }
        }
      }
    }
    productsToLoad.value.addAll(finalList);
    apiState.value = APIState.COMPLETED;
  }

  completePredelivery({required Map<String, dynamic> params}) async {
    apiState.value = APIState.LOADING;
    String message =
        await PredeliveryServiceProvider().completePredelivery(params: params);
    SnackbarSupporter.showSuccessSnackbar(
        title: 'Predelivery', message: message);
    if (message == 'Pre-delivery completed succesfully') {
      _preceedForPostDelivery(message: message);
    }
    apiState.value = APIState.COMPLETED;
  }

  @override
  void onInit() {
    predeliveryStepsModel = Rx(PredeliveryStepsModel());
    subTaskSteps = Rx([]);
    productsToLoad = Rx([]);
    inspectionSteps = Rx(InspectionSteps());
    _getPredeliverySteps();
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

  void showLoadProductsPopup() {
    LoadProductDialogView();
  }

  void updateSelectedItem({required List<SubTaskSteps> items}) {
    subTaskSteps.value = [];
    subTaskSteps.value = items;
  }

  void _preceedForPostDelivery({message}) {
    Get.dialog(ActionDialogView(
      message: '$message\n\nProceed to Post Delivery!',
      yesAction: () {
        Get.offNamed(Routes.DURING_DELIVERY_TASKS_LIST);
      },
      noAction: () {
        Get.offAllNamed(Routes.DASHBOARD);
      },
    ));
  }
}

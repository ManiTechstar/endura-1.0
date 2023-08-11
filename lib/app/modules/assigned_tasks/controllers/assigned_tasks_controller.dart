import 'package:endura_app/app/data/model/assigned_schedules_list_model.dart';
import 'package:endura_app/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:endura_app/app/modules/login/controllers/login_controller.dart';
import 'package:endura_app/app/providers/schedule_service_provider.dart';
import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/dialogs/views/action_dialog_view.dart';
import 'package:endura_app/core/dialogs/views/task_details_dialog_view.dart';
import 'package:endura_app/core/utilities/snackbar_supporter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum SelectTab { PENDING, COMPLETED, FAIL }

class AssignedTasksController extends BaseController {
  var name = 'Products'.obs;

  late Rx<List<TaskDetails>> todosList;
  late Rx<List<TaskDetails>> completedList;
  late Rx<List<TaskDetails>> failTaskList;

  late Rx<AssignedSchedulesListModel> assignedTaskModel;

  final selectedTab = SelectTab.PENDING.obs;

  @override
  void onInit() {
    todosList = Rx.new([]);
    failTaskList = Rx.new([]);
    completedList = Rx.new([]);
    // preDeliveryIds = Rx.new([]);

    assignedTaskModel = Rx.new(AssignedSchedulesListModel());
    getUserTasks();
    super.onInit();
  }

  @override
  void onReady() {
    print('ON READY');
    super.onReady();
  }

  @override
  void onClose() {
    print('ON READY');
    super.onClose();
  }

  Future<AssignedSchedulesListModel?> getUserTasks() async {
    var userData = Get.find<LoginController>();
    var routesSelectorController = Get.find<RoutesSelectorController>();

    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;

        todosList.value.clear();
        completedList.value.clear();
        failTaskList.value.clear();

        AssignedSchedulesListModel model =
            await ScheduleServiceProvider().getUserSchedules(params: {
          "user_email": userData.userModel.value.email, //userData.email,
          "startDate":
              DateFormat("yyyy-MM-dd").format(DateTime.now()), //startDate,
          "route":
              routesSelectorController.selectedRouteName.value // selectedRoute
        });

        _updateTaskDetailsList(model);
        return model;
      } catch (e) {
        SnackbarSupporter.showFailureSnackbar(
            title: 'Error', message: e.toString());
        apiState.value = APIState.COMPLETED;
        return null;
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Network', message: 'Please Check Your Network Connection');
      return null;
    }
  }

  void _updateTaskDetailsList(AssignedSchedulesListModel model) {
    assignedTaskModel.value = model;

    for (var element in model.result!) {
      if (element.taskDetails!.isNotEmpty) {
        for (TaskDetails task in element.taskDetails!) {
          if (task.taskStatus!.toLowerCase() == 'pending') {
            todosList.value.add(task);
          } else if (task.taskStatus!.toLowerCase() == 'completed') {
            completedList.value.add(task);
          } else {
            failTaskList.value.add(task);
          }
        }
      }
    }

    apiState.value = APIState.COMPLETED;
  }

  void selectItem(List<TaskDetails> details) {
    switch (selectedTab.value) {
      case SelectTab.PENDING:
        Get.find<DriverHomeController>().preDeliveryIds.value = [];
        todosList.value = [];
        todosList.value = details;
        for (int x = 0; x < details.length; x++) {
          if (details[x].isCheckedForPreDelivery) {
            if (!Get.find<DriverHomeController>()
                .preDeliveryIds
                .value
                .contains(details[x].sId!)) {
              Get.find<DriverHomeController>()
                  .preDeliveryIds
                  .value
                  .add(details[x].sId!);
            }
          }
        }
        break;
      case SelectTab.FAIL:
        print('FAIL');

        break;
      case SelectTab.COMPLETED:
        print('Completed');
        break;
    }
  }

  void viewTaskDetails({openTask, action, showActionButton}) {
    Get.dialog(TaskDetailsDialogView(
      task: openTask,
      actionTitle: openTask.isCheckedForPreDelivery
          ? 'Do not Add to pre-delivery'
          : 'Add to pre-delivery',
      assignToYourSelf: action,
      hasActionButton: showActionButton,
    ));
  }

  changeTheTab({tab}) {
    selectedTab.value = tab;
  }

  proceedForPreDeliveryConfirmation() {
    Get.dialog(ActionDialogView(
      message:
          'Pre-Delivery can perform only once in a day. Select tasks before Proceeding for Pre-Delivery!\n\nAre you sure want to Proceed For Pre-Delivery?',
      yesAction: () {
        Get.back();
        Get.toNamed(
          Routes.PREDELIVERY,
        );
      },
    ));
  }
}

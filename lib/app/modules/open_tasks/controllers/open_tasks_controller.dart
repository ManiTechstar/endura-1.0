import 'package:fieldapp/app/data/model/open_tasks_list_model.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/providers/schedule_service_provider.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/dialogs/views/action_dialog_view.dart';
import 'package:fieldapp/core/dialogs/views/task_details_dialog_view.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum SelectedTab { PAST, CURRENT, FUTURE }

class OpenTasksController extends BaseController {
  final selectedTab = 'CURRENT'.obs;

  late Rx<List<OpenTask>> openTasks;

  Rx<List<OpenTask>> pastTasks = Rx.new([]);

  Rx<List<OpenTask>> futureTasks = Rx.new([]);
  Rx<List<OpenTask>> currentTasks = Rx.new([]);

  late TextEditingController searchController;

  Rx<String> searchValue = Rx.new('');
  @override
  void onInit() {
    openTasks = Rx.new([]);

    searchController = TextEditingController();
    getOpenTasks();
    super.onInit();
  }

  Future<void> getOpenTasks() async {
    var userData = Get.find<LoginController>();
    var rutesSelectorController = Get.find<RoutesSelectorController>();

    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        OpenTasksListModel openTasksModel =
            await ScheduleServiceProvider().getOpenSchedules(params: {
          "user_email": userData.userModel.value.email, //userData.email,
          "date": DateFormat("yyyy-MM-dd").format(DateTime.now()), //startDate,
          "route":
              rutesSelectorController.selectedRouteName.value // selectedRoute
        });
        openTasks.value = openTasksModel.result!;
        pastTasks.value.clear();
        currentTasks.value.clear();
        futureTasks.value.clear();
        updateTasksLists();
        apiState.value = APIState.COMPLETED;
      } catch (e) {
        SnackbarSupporter.showFailureSnackbar(
            title: 'Error', message: e.toString());
        apiState.value = APIState.COMPLETED;
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Network', message: 'Please Check Your Network Connection');
    }
  }

  void pickATask({taskId, String? taskName}) {
    Get.dialog(ActionDialogView(
      message: 'Are you sure want to assign $taskName task to yourself?',
      yesAction: () {
        Get.back();
        _doApiCall(taskId: taskId);
      },
      noAction: () {
        Get.back();
      },
    ));
  }

  void viewTaskDetails({openTask, action}) {
    Get.dialog(TaskDetailsDialogView(
      task: openTask,
      actionTitle: 'Assign to your self!',
      assignToYourSelf: () {
        Get.back();
        pickATask(
          taskId: openTask.sId,
          taskName: openTask.taskName,
        );
      },
    ));
  }

  void _doApiCall({taskId}) async {
    try {
      LoginController loginController = Get.find<LoginController>();
      bool isInternetConnected = await isInternetAvailable();
      if (isInternetConnected) {
        apiState.value = APIState.LOADING;
        String message = await ScheduleServiceProvider().pickATask(params: {
          "id": taskId,
          "empId": loginController.userModel.value.empId
        });
        SnackbarSupporter.showSuccessSnackbar(
            title: 'Success', message: message);

        await getOpenTasks();
        apiState.value = APIState.COMPLETED;
        if (openTasks.value.isEmpty) {
          Get.dialog(ActionDialogView(
            message:
                'There are to open tasks ${selectedTab.toString().toLowerCase()}. would you like to see assigned tasks to proceed for pre-delivery',
            yesAction: () {
              Get.back();
              Get.offNamed(Routes.ASSIGNED_TASKS);
            },
          ));
        }
      } else {
        SnackbarSupporter.showFailureSnackbar(
            title: 'Network', message: 'Please Check Your Network Connection');
      }

      print(openTasks.value.length);
    } catch (e) {
      apiState.value = APIState.COMPLETED;
      SnackbarSupporter.showFailureSnackbar(title: 'Fail', message: e);
    }
  }

  void updateSelectedTasks({index}) {
    if (selectedTab.value == 'PAST') {
      List<OpenTask> tasks = pastTasks.value;

      pastTasks.value = [];
      tasks[index].isSelected = !tasks[index].isSelected!;
      pastTasks.value.addAll(tasks);
    } else if (selectedTab.value == 'FUTURE') {
      List<OpenTask> tasks = futureTasks.value;

      futureTasks.value = [];
      tasks[index].isSelected = !tasks[index].isSelected!;
      futureTasks.value.addAll(tasks);
    } else {
      List<OpenTask> tasks = currentTasks.value;

      currentTasks.value = [];
      tasks[index].isSelected = !tasks[index].isSelected!;
      currentTasks.value.addAll(tasks);
    }
  }

  void updateTasksLists() {
    for (var element in openTasks.value) {
      if (element.taskStartsFrom == 'PAST') {
        pastTasks.value.add(element);
      } else if (element.taskStartsFrom == 'FUTURE') {
        futureTasks.value.add(element);
      } else {
        currentTasks.value.add(element);
      }
    }
  }

  doMultiSelectAPICall() async {
    apiState.value = APIState.LOADING;
    LoginController loginController = Get.find<LoginController>();

    String message = await ScheduleServiceProvider().pickMultiTasks(params: {
      "taskIDs": _getIds(),
      "empId": loginController.userModel.value.empId
    });
    SnackbarSupporter.showSuccessSnackbar(title: 'Success', message: message);
    await getOpenTasks();
    apiState.value = APIState.COMPLETED;
    if (openTasks.value.isEmpty) {
      Get.dialog(ActionDialogView(
        message:
            'There are to open tasks ${selectedTab.toString().toLowerCase()}. would you like to see assigned tasks to proceed for pre-delivery',
        yesAction: () {
          Get.back();
          Get.offNamed(Routes.ASSIGNED_TASKS);
        },
      ));
    }
  }

  _getIds() {
    List<String> ids = [];
    if (selectedTab.value == 'PAST') {
      for (var element
          in pastTasks.value.where((element) => element.isSelected!)) {
        ids.add(element.sId!);
      }
    } else if (selectedTab.value == 'FUTURE') {
      for (var element
          in futureTasks.value.where((element) => element.isSelected!)) {
        ids.add(element.sId!);
      }
    } else {
      for (var element
          in currentTasks.value.where((element) => element.isSelected!)) {
        ids.add(element.sId!);
      }
    }
    return ids;
  }
}

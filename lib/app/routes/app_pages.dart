import 'package:get/get.dart';

import '../modules/analysis_form/bindings/analysis_form_binding.dart';
import '../modules/analysis_form/views/analysis_form_view.dart';
import '../modules/assigned_tasks/bindings/assigned_tasks_binding.dart';
import '../modules/assigned_tasks/views/assigned_tasks_view.dart';
import '../modules/cummulative_products/bindings/cummulative_products_binding.dart';
import '../modules/cummulative_products/views/cummulative_products_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/during_delivery/bindings/during_delivery_binding.dart';
import '../modules/during_delivery/views/during_delivery_view.dart';
import '../modules/during_delivery_tasks_list/bindings/during_delivery_tasks_list_binding.dart';
import '../modules/during_delivery_tasks_list/views/during_delivery_tasks_list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/open_tasks/bindings/open_tasks_binding.dart';
import '../modules/open_tasks/views/open_tasks_view.dart';
import '../modules/predelivery/bindings/predelivery_binding.dart';
import '../modules/predelivery/views/predelivery_view.dart';
import '../modules/service_report/bindings/service_report_binding.dart';
import '../modules/service_report/views/service_report_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_REPORT,
      page: () => const ServiceReportView(),
      binding: ServiceReportBinding(),
    ),
    GetPage(
      name: _Paths.ANALYSIS_FORM,
      page: () => AnalysisFormView(),
      binding: AnalysisFormBinding(),
    ),
    GetPage(
      name: _Paths.OPEN_TASKS,
      page: () => OpenTasksView(),
      binding: OpenTasksBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGNED_TASKS,
      page: () => const AssignedTasksView(),
      binding: AssignedTasksBinding(),
    ),
    GetPage(
      name: _Paths.CUMMULATIVE_PRODUCTS,
      page: () => const CummulativeProductsView(),
      binding: CummulativeProductsBinding(),
    ),
    GetPage(
      name: _Paths.PREDELIVERY,
      page: () => PredeliveryView(),
      binding: PredeliveryBinding(),
    ),
    GetPage(
      name: _Paths.DURING_DELIVERY,
      page: () => const DuringDeliveryView(),
      binding: DuringDeliveryBinding(),
    ),
    GetPage(
      name: _Paths.DURING_DELIVERY_TASKS_LIST,
      page: () => const DuringDeliveryTasksListView(),
      binding: DuringDeliveryTasksListBinding(),
    ),
  ];
}

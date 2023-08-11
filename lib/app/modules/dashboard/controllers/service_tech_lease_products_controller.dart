import 'package:endura_app/app/data/model/products_by_well_model.dart';
import 'package:endura_app/app/modules/service_report/controllers/service_report_controller.dart';
import 'package:endura_app/app/providers/service_report_provider.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:get/get.dart';

class ServiceTechLeaseProductsController extends BaseController {
  final model = ProductsByWellModel().obs;
  getAllProductsByLease({wellId}) async {
    apiState.value = APIState.LOADING;
    model.value =
        await ServiceReportProvider().getProductsByWellId(wellId: wellId);
    apiState.value = APIState.COMPLETED;
  }
}

import 'package:fieldapp/app/data/model/products_by_location_model.dart';
import 'package:fieldapp/app/data/parser_models/chemical_list_parser.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/account_representative_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_report_company_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_report_lease_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/warehouse_selector_controller.dart';
import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/providers/service_report_provider.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ServiceReportController extends BaseController {
  late Rx<ProductsByLocationModel> model;
  late Rx<List<Products>> products;

  final nameControllers = <TextEditingController>[].obs;
  final gallonsDeliveredControllers = <TextEditingController>[].obs;
  final gallonsOnHandControllers = <TextEditingController>[].obs;
  final recRateControllers = <TextEditingController>[].obs;
  final actualRateControllers = <TextEditingController>[].obs;
  final commentsControllers = <TextEditingController>[].obs;

  var length = 0.obs;
  Rx<List<bool>> rate = Rx([]);
  Rx<List<bool>> soar = Rx([]);

  var mainSoar = false.obs;

//controllers
  late TextEditingController countyContoller;
  late TextEditingController boalController;
  late TextEditingController rateController;
  late TextEditingController specialTreatController;
  late TextEditingController notesController;

  late AccountRepresentativeSelectorController
      accountRepresentativeSelectorController;
  @override
  void onInit() {
    model = Rx.new(ProductsByLocationModel());
    products = Rx.new([]);
    _initEditContollers();
    Get.find<WarehouseSelectorController>().getAllWarehouses();

    accountRepresentativeSelectorController =
        Get.find<AccountRepresentativeSelectorController>();
    accountRepresentativeSelectorController.getAllRepresentative();

    super.onInit();
  }

  getProductsByLocation({customerId, location}) async {
    model.value = await ServiceReportProvider()
        .getProductsByLocation(customerId: customerId, location: location);

    clearAll();
    _updateProducts();
  }

  void _updateProducts() {
    if (model.value.result!.isNotEmpty) {
      for (ProductsResult result in model.value.result!) {
        if (result.products!.isNotEmpty) {
          for (Products product in result.products!) {
            nameControllers.add(TextEditingController(text: product.productId));
            gallonsDeliveredControllers.add(TextEditingController());
            gallonsOnHandControllers.add(TextEditingController());
            recRateControllers.add(TextEditingController(text: product.uomGal));
            actualRateControllers.add(TextEditingController());
            commentsControllers.add(TextEditingController());
            rate.value.add(false);
            soar.value.add(false);
          }
          products.value.addAll(result.products!);
          length.value = nameControllers.length;
          print(length.value);
        }
      }
    }
  }

  void addNewEmptyProduct() {
    nameControllers.add(TextEditingController());
    gallonsDeliveredControllers.add(TextEditingController());
    gallonsOnHandControllers.add(TextEditingController());
    recRateControllers.add(TextEditingController());
    actualRateControllers.add(TextEditingController());
    commentsControllers.add(TextEditingController());
    rate.value.add(false);
    soar.value.add(false);
  }

  void removeProductFromList(int index) {
    nameControllers.removeAt(index);
    gallonsDeliveredControllers.removeAt(index);
    gallonsOnHandControllers.removeAt(index);
    recRateControllers.removeAt(index);
    actualRateControllers.removeAt(index);
    commentsControllers.removeAt(index);
    rate.value.removeAt(index);
    soar.value.removeAt(index);
  }

  void clearAll() {
    products.value.clear();
    nameControllers.clear();
    gallonsDeliveredControllers.clear();
    gallonsOnHandControllers.clear();
    recRateControllers.clear();
    actualRateControllers.clear();
    commentsControllers.clear();
    rate.value.clear();
    soar.value.clear();
    update();
  }

  void submitServiceReport() async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      if (_validateForm()) {
        try {
          apiState.value = APIState.LOADING;
          Map<String, dynamic> params = _getParams();
          String message =
              await ServiceReportProvider().submitServiceReport(params: params);
          SnackbarSupporter.showSuccessSnackbar(
              title: 'Success', message: message);

          clearAll();
          mainSoar.value = false;
          Get.find<ServiceReportLeaseSelectorController>()
              .selectedLeaseName
              .value = 'Select Lease';
          apiState.value = APIState.COMPLETED;
        } catch (e) {
          SnackbarSupporter.showFailureSnackbar(
              title: 'Error', message: e.toString());
        }
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Connectivity Exception',
          message: 'Please check your network');
    }
  }

  bool _validateForm() {
    ServiceReportCompanySelectorController companySelectorController =
        Get.find<ServiceReportCompanySelectorController>();
    ServiceReportLeaseSelectorController leaseSelectorController =
        Get.find<ServiceReportLeaseSelectorController>();

    if (companySelectorController.selectedCompanyName.value ==
        'Select Company') {
      SnackbarSupporter.showFailureSnackbar(
          title: '', message: 'Please Select Company');
      return false;
    } else if (leaseSelectorController.selectedLeaseName.value ==
        'Select Lease') {
      SnackbarSupporter.showFailureSnackbar(
          title: '', message: 'Please Select Lease');
      return false;
    } else if (!mainSoar.value) {
      SnackbarSupporter.showFailureSnackbar(
          title: 'S.O.A.R', message: 'Please Check S.O.A.R');
      return false;
    } else {
      return true;
    }
  }

  Map<String, dynamic> _getParams() {
    List<ChemicalListParamsModel> chemicalList = _getChemicalList();
    LoginController loginController = Get.find<LoginController>();
    WarehouseSelectorController warehouseSelectorController =
        Get.find<WarehouseSelectorController>();

    ServiceReportCompanySelectorController companySelectorController =
        Get.find<ServiceReportCompanySelectorController>();
    ServiceReportLeaseSelectorController leaseSelectorController =
        Get.find<ServiceReportLeaseSelectorController>();

    AccountRepresentativeSelectorController representativeSelectorController =
        Get.find<AccountRepresentativeSelectorController>();
    loginController.userModel.value.empId;
    var params = {
      "employeeId": loginController.userModel.value.empId,
      'salesRep': representativeSelectorController.selectedRepresentativeId,
      "lease": leaseSelectorController.selectedLeaseName.value,
      "county": countyContoller.text,
      "boal": boalController.text,
      "chemical": _getChemicalList(),
      "company": companySelectorController.selectedCompanyName.value,
      "rate": rateController.text,
      "soar": true,
      "specialTreat": specialTreatController.text,
      "notes": notesController.text,
      "warehouse": warehouseSelectorController.selectedWarehouseName.value,
    };
    return params;
  }

  List<ChemicalListParamsModel> _getChemicalList() {
    List<ChemicalListParamsModel> chemicalList = [];
    if (nameControllers.isNotEmpty) {
      for (int n = 0; n < nameControllers.length; n++) {
        chemicalList.add(ChemicalListParamsModel(
            name: nameControllers[n].text,
            gallonsDelivered: gallonsDeliveredControllers[n].text,
            gallonsOnHand: gallonsOnHandControllers[n].text,
            recRate: recRateControllers[n].text,
            actualRate: actualRateControllers[n].text,
            comments: commentsControllers[n].text,
            rate: rate.value[n].toString(),
            soar: soar.value[n]));
      }
    }
    return chemicalList;
  }

  void _initEditContollers() {
    countyContoller = TextEditingController();
    boalController = TextEditingController();
    rateController = TextEditingController();
    specialTreatController = TextEditingController();
    notesController = TextEditingController();
  }
}

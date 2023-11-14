import 'package:fieldapp/app/data/model/account_representative_list_model.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/account_representative_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/analysis_form_company_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/analysis_form_lease_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/warehouse_selector_controller.dart';
import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/providers/analysis_form_provider.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalysisFormController extends BaseController {
  //OBS objects
  final index = 0.obs;
  final showOtherFields = false.obs;
  final selectedColoration = 'Select Coloration'.obs;

  PageController pageController = PageController(initialPage: 0);
  // late RoutesSelectorController routesSelectorController;
  late WarehouseSelectorController warehouseSelectorController;
  late AccountRepresentativeSelectorController
      accountRepresentativeSelectorController;

//Header Text Editing controllers
  late TextEditingController samplingPointController;
  late TextEditingController cityController;
  late TextEditingController shipToController;
  late TextEditingController casingSizeController;
  late TextEditingController tubingSizeController;
  late TextEditingController rodSizeOneController;
  late TextEditingController rodSizeTwoController;
  late TextEditingController rodSizeThreeController;
  late TextEditingController depthOfHoldController;
  late TextEditingController formationController;
  late TextEditingController wopOneController;
  late TextEditingController wopTwoController;
  late TextEditingController sflController;
  late TextEditingController nypController;

  //Production Text Editing controllers
  late TextEditingController oilBPDController;
  late TextEditingController waterBPDController;
  late TextEditingController mcfController;
  late TextEditingController mmcfController;
  late TextEditingController gravityController;
  late TextEditingController estimatedChloridesController;
  late TextEditingController freshController;
  late TextEditingController brineController;
  late TextEditingController workingPressureController;
  late TextEditingController shutInController;
  late TextEditingController productioOtherOneController;
  late TextEditingController productioOtherTwoController;
  late TextEditingController eg20fController;
  late TextEditingController commentsController;

  //chemicals in use Text Editing controllers
  late TextEditingController problemLocatioController;
  late TextEditingController otherThreeController;
  late TextEditingController productOrBrandOneController;
  late TextEditingController productOrBrandTwoController;
  late TextEditingController productOrBrandThreeController;
  late TextEditingController qtydOneController;
  late TextEditingController qtyTwoController;
  late TextEditingController qtyThreeController;
  late TextEditingController detailsController;

  //well checkboxes
  var isGas = false.obs;
  var isOil = false.obs;
  var isWater = false.obs;
  var isPumping = false.obs;
  var isFlowing = false.obs;
  var isInspection = false.obs;

  //productioOther checkboxes
  var isGasLift = false.obs;
  var isHydraulicLift = false.obs;
  var isBeamPump = false.obs;
  var isKabaPump = false.obs;
  var isRedaPump = false.obs;
  var isSWD = false.obs;

  //Equipment checkboxes
  var isSapator = false.obs;
  var isHeaterTreater = false.obs;
  var isStockTank = false.obs;
  var isFWK = false.obs;
  var isPit = false.obs;
  var isGunBarren = false.obs;
  var isLact = false.obs;
  var isChemelctric = false.obs;

  // select problem check boxes
  var isWaterQuality = false.obs;
  var isCorrosin = false.obs;
  var isEmulsion = false.obs;
  var isReverse = false.obs;
  var isFoam = false.obs;
  var isOilCarryOver = false.obs;
  var isParaffin = false.obs;
  var isScale = false.obs;
  var isTankBottom = false.obs;
  var isIronSulfide = false.obs;

  // Chemicals in use others
  var isSelectAll = false.obs;
  var isNeedAnalysis = false.obs;
  var isNeedRecommendations = false.obs;
  var isSendCopiesToMe = false.obs;
  var isSCP = false.obs;

  @override
  void onInit() {
    // routesSelectorController = Get.find<RoutesSelectorController>();
    warehouseSelectorController = Get.find<WarehouseSelectorController>();
    accountRepresentativeSelectorController =
        Get.find<AccountRepresentativeSelectorController>();

    _initControllers();
    // routesSelectorController.getAllRoutes();
    warehouseSelectorController.getAllWarehouses();
    accountRepresentativeSelectorController.getAllRepresentative();

    super.onInit();
  }

  void navigateToPreviousPage() {
    index.value--;
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void navigateToNextPage() {
    if (index.value == 0) {
      if (_validateAFHeader()) {
        index.value++;
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    } else if (index.value == 1) {
      if (showOtherFields.value) {
        index.value++;
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        SnackbarSupporter.showFailureSnackbar(
            title: '', message: 'Fill all the * Fields');
      }
    } else {
      if (_validateAFChemicalInUse()) {
        _submitAnalysisFormToApi();
      } else {
        SnackbarSupporter.showFailureSnackbar(
            title: '', message: 'Fill or Select * fileds');
      }
    }
  }

  bool _validateAFHeader() {
    AnalysisFormCompanySelectorController
        analysisFormCompanySelectorController =
        Get.find<AnalysisFormCompanySelectorController>();
    if (samplingPointController.text.isEmpty) {
      SnackbarSupporter.showFailureSnackbar(
          title: '', message: 'Please Enter Sampling Point');
      return false;
    } else if (accountRepresentativeSelectorController
            .selectedRepresentativeName.value ==
        'Select Representative') {
      SnackbarSupporter.showFailureSnackbar(
          title: '', message: 'Please Select Representative');
      return false;
    } else if (analysisFormCompanySelectorController
            .selectedCompanyName.value ==
        'Select Company') {
      SnackbarSupporter.showFailureSnackbar(
          title: '', message: 'Please Select Company');
      return false;
    } else {
      return true;
    }
  }

  bool _validateAFProduction() {
    // validate the production form
    return true;
  }

  bool _validateAFChemicalInUse() {
    return (problemLocatioController.text.isNotEmpty &&
        (isCorrosin.value ||
            isEmulsion.value ||
            isReverse.value ||
            isFoam.value ||
            isOilCarryOver.value ||
            isParaffin.value ||
            isScale.value ||
            isTankBottom.value ||
            isIronSulfide.value ||
            isWaterQuality.value) &&
        (isNeedAnalysis.value ||
            isNeedRecommendations.value ||
            isSendCopiesToMe.value ||
            isSCP.value));
  }

  void _submitAnalysisFormToApi() async {
    bool isInternetConnected = await isInternetAvailable();
    if (isInternetConnected) {
      try {
        apiState.value = APIState.LOADING;
        var params = _getParams();
        String message =
            await AnalysisFormProvider().submitAnalysisForm(params: params);
        apiState.value = APIState.COMPLETED;
        Get.back();
        SnackbarSupporter.showSuccessSnackbar(
            title: 'Analysis', message: message);
      } catch (e) {
        SnackbarSupporter.showFailureSnackbar(title: '', message: e.toString());
      }
    } else {
      SnackbarSupporter.showFailureSnackbar(
          title: 'Connectivity Exception',
          message: 'Please check your network');
    }

    //do api call to submit analysis form
  }

  //To initialize all the controllers
  void _initControllers() {
    samplingPointController = TextEditingController();
    cityController = TextEditingController();
    shipToController = TextEditingController();
    casingSizeController = TextEditingController();
    tubingSizeController = TextEditingController();
    rodSizeOneController = TextEditingController();
    rodSizeTwoController = TextEditingController();
    rodSizeThreeController = TextEditingController();
    depthOfHoldController = TextEditingController();
    formationController = TextEditingController();
    wopOneController = TextEditingController();
    wopTwoController = TextEditingController();
    sflController = TextEditingController();
    nypController = TextEditingController();

    oilBPDController = TextEditingController();
    waterBPDController = TextEditingController();
    mcfController = TextEditingController();
    mmcfController = TextEditingController();
    gravityController = TextEditingController();
    estimatedChloridesController = TextEditingController();
    freshController = TextEditingController();
    brineController = TextEditingController();
    workingPressureController = TextEditingController();
    shutInController = TextEditingController();
    productioOtherOneController = TextEditingController();
    productioOtherTwoController = TextEditingController();
    eg20fController = TextEditingController();
    commentsController = TextEditingController();

    problemLocatioController = TextEditingController();
    otherThreeController = TextEditingController();
    productOrBrandOneController = TextEditingController();
    productOrBrandTwoController = TextEditingController();
    productOrBrandThreeController = TextEditingController();
    qtydOneController = TextEditingController();
    qtyTwoController = TextEditingController();
    qtyThreeController = TextEditingController();
    detailsController = TextEditingController();
  }

  void onChangelistener(String val) {
    print('onChangelistener');
    showOtherFields.value = (oilBPDController.text.isNotEmpty &&
        waterBPDController.text.isNotEmpty &&
        mcfController.text.isNotEmpty &&
        estimatedChloridesController.text.isNotEmpty);
  }

  Map<String, Object?> _getParams() {
    LoginController loginController = Get.find<LoginController>();

    AnalysisFormCompanySelectorController
        analysisFormCompanySelectorController =
        Get.find<AnalysisFormCompanySelectorController>();

    AnalysisFormLeaseSelectorController analysisLeaseSelectorController =
        Get.find<AnalysisFormLeaseSelectorController>();

    var address = cityController.text != '' && shipToController.text != ''
        ? '${shipToController.text},${cityController.text}'
        : cityController.text == '' && shipToController.text != ''
            ? shipToController.text
            : cityController.text != '' && shipToController.text == ''
                ? cityController.text == '' && shipToController.text != ''
                : '';
    AccountRepresentativeListModelResult representative =
        accountRepresentativeSelectorController.model.value.result!.firstWhere(
            (element) =>
                element.name ==
                accountRepresentativeSelectorController
                    .selectedRepresentativeName.value);

    return {
      "employeeId": loginController.userModel.value.empId,
      // "route": routesSelectorController.selectedRouteName.value,
      "warehouse": warehouseSelectorController.selectedWarehouseName.value ==
              'Select Warehouse'
          ? ''
          : warehouseSelectorController.selectedWarehouseName.value,
      "salesRep": representative.sId,
      "company":
          analysisFormCompanySelectorController.selectedCompanyName.value,
      "address": address,
      "lease": analysisLeaseSelectorController.selectedLeaseName.value,
      "samplingPoint": samplingPointController.text,
      "casingSize": casingSizeController.text,
      "tubingSize": tubingSizeController.text,
      "rodStringSize": [
        {"field_1": rodSizeOneController.text},
        {"field_2": rodSizeTwoController.text},
        {"field_3": rodSizeThreeController.text}
      ],
      "depthOfHole": depthOfHoldController.text,
      "formation": formationController.text,
      "widthOfPerfs": [
        {"field_1": wopOneController.text},
        {"field_2": wopOneController.text}
      ],
      "standingFuelLevel": sflController.text,
      "yearsProduced": nypController.text,
      "fluids": [
        {
          "oil": waterBPDController.text,
          "water": waterBPDController.text,
          "gas": [
            {"gasMcf": mcfController.text},
            {"gasMmcf": mmcfController.text}
          ],
          "gravity": gravityController.text,
          "chlorides": estimatedChloridesController.text,
          "coloration": selectedColoration.value == 'Select Coloration'
              ? ''
              : selectedColoration.value, //coloration,

          "fresh": freshController.text,
          "brine": brineController.text,

          "workingPressure": workingPressureController.text,
          "shutIn": shutInController.text
        }
      ],
      "well": {
        "well_1": [
          {"gas": isGas.value},
          {"oil": isOil.value},
          {"water": isWater.value},
          {"pumping": isPumping.value},
          {"flowing": isFlowing.value},
          {"inspection": isInspection.value},
          {"other": productioOtherOneController.text},
        ],
        "well_2": [
          {"gasLift": isGasLift.value},
          {"hydraulicLift": isHydraulicLift.value},
          {"beamPump": isBeamPump.value},
          {"kobePump": isKabaPump.value},
          {"redaPump": isRedaPump.value},
          {"swd": isSWD.value},
          {"other": productioOtherTwoController.text}
        ]
      },
      "equipment": [
        {"separator": isSapator.value},
        {"heaterTreater": isHeaterTreater.value},
        {"stockTank": isStockTank.value},
        {"fireWaterKnockout": isFWK.value},
        {"pit": isPit.value},
        {"gunBarrel": isGunBarren.value},
        {"lact": isLact.value},
        {"chemelctric": isChemelctric.value},
        {"other": commentsController.text},
        {"temp": eg20fController.text}
      ],
      "chemicalsInUse": {
        "products": [
          {
            "product": productOrBrandOneController.text,
            "quanity": qtydOneController.text
          },
          {
            "product": productOrBrandTwoController.text,
            "quanity": qtyTwoController.text
          },
          {
            "product": productOrBrandThreeController.text,
            "quanity": qtyThreeController.text
          },
        ],
        "problemLocation": problemLocatioController.text,
        "other": otherThreeController.text,
        "problem": [
          {"corrosion": isCorrosin.value},
          {"emulsion": isEmulsion.value},
          {"reverse": isReverse.value},
          {"foam": isFoam.value},
          {"oilCarryOver": isOilCarryOver.value},
          {"paraffin": isParaffin.value},
          {"scale": isScale.value},
          {"tankBottom": isTankBottom.value},
          {"ironSulfide": isIronSulfide.value},
          {"waterQuality": isWaterQuality.value},
          {"other": otherThreeController.text}
        ],
        "needAnalysis": isNeedAnalysis.value,
        "needRecommendations": isNeedRecommendations.value,
        "sendAllCopiesToMe": isSendCopiesToMe.value,
        "sendCustomerCopy": isSCP.value,
        "details": detailsController.text
      }
    };
  }
}

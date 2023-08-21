// ignore_for_file: must_be_immutable

import 'package:endura_app/app/modules/dashboard/controllers/service_tech_lease_products_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/service_tech_home_company_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/service_tech_home_lease_selector_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/search_selection_dialog_view.dart';
import 'package:endura_app/core/base/views/search_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ServiceTechHomeLeasesSearchSelectView
    extends SearchView<ServiceTechHomeFormLeaseSelectorController> {
  ServiceTechHomeLeasesSearchSelectView({Key? key}) : super(key: key);

  @override
  Widget cBuild(BuildContext context,
      ServiceTechHomeFormLeaseSelectorController cController) {
    ServiceTechCompanySelectorController companySelectorController =
        Get.find<ServiceTechCompanySelectorController>();

    return Obx(
      () => companySelectorController.selectedCompanyName.value !=
              'Select Company'
          ? cController.apiState.value == APIState.COMPLETED
              ? cController.model.value.result!.isNotEmpty
                  ? _getLeaseFieldWidget(cController)
                  : _noLeaseFound(
                      companySelectorController.selectedCompanyName.value)
              : _getShimmerLoader()
          : const SizedBox(),
    );
  }
}

_getLeaseFieldWidget(ServiceTechHomeFormLeaseSelectorController cController) {
  return InkWell(
      onTap: () async {
        var item = await Get.dialog(SearchSelectionDialogView(
          items: cController.wells,
          searchHint: 'Select Lease',
          title: 'Leases',
        ));

        if (item != null) {
          List list = cController.model.value.result!
              .where(
                (element) => element.location == item,
              )
              .toList();
          print('SELECTED ITEM NAME ==> $item');
          print('ServiceTechLeaseProductsController ==> ${list[0].sId}');
          Get.find<ServiceTechLeaseProductsController>()
              .getAllProductsByLease(wellId: list[0].sId);
          cController.selectedLeaseName(item);
          cController.selectedWellId.value = list[0].sId;
        }

        // if (item != null) {
        //   cController.selectedLeaseName(item);
        // }
      },
      child: Containers().getSelectorContainer(
        name: cController.selectedLeaseName.value,
      ));
}

Widget _noLeaseFound(companyName) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "No lease found for $companyName",
        style: TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            fontFamily: FontFamilyConstants.firasans),
      ),
    ),
  );
}

_getShimmerLoader() {
  return Shimmer.fromColors(
    baseColor: ColorConstants.color2.withOpacity(0.05),
    highlightColor: ColorConstants.black1.withOpacity(0.2),
    child: Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      height: 60.0,
      width: double.infinity,
    ),
  );
}

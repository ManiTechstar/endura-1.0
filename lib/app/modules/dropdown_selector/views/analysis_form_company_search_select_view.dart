// ignore_for_file: must_be_immutable

import 'package:fieldapp/app/modules/dropdown_selector/controllers/account_representative_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/analysis_form_company_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/analysis_form_lease_selector_controller.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/search_selection_dialog_view.dart';
import 'package:fieldapp/core/base/views/search_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AnalysisFormCompanySearchSelectView
    extends SearchView<AnalysisFormCompanySelectorController> {
  AnalysisFormCompanySearchSelectView({Key? key}) : super(key: key);

  @override
  Widget cBuild(
      BuildContext context, AnalysisFormCompanySelectorController cController) {
    return Obx(
      () => cController.apiState.value == APIState.LOADING
          ? _getShimmerLoader()
          : cController.companies.isEmpty
              ? _noLeaseFound(cController.selectedCompanyName.value)
              : InkWell(
                  onTap: () async {
                    var item = await Get.dialog(SearchSelectionDialogView(
                      items: cController.companies,
                      searchHint: 'Select Company',
                      title: 'Company',
                    ));

                    if (item != null) {
                      print('SELECTED ITEM NAME ==> $item');
                      List list = cController.model.value.result!
                          .where((element) => element.customerName == item)
                          .toList();

                      Get.find<AnalysisFormLeaseSelectorController>()
                          .getLocationsByCustomerId(
                              customerId: list[0].customerId);
                      cController.setCompanyName(name: item);
                    }
                  },
                  child: Containers().getSelectorContainer(
                    name: cController.selectedCompanyName.value,
                  ),
                ),
    );
  }
}

Widget _noLeaseFound(companyName) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "No Companies found for ${Get.find<AccountRepresentativeSelectorController>().selectedRepresentativeName.value}",
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

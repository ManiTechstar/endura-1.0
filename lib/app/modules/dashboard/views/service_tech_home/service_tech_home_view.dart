import 'package:fieldapp/app/modules/dashboard/controllers/service_tech_home_controller.dart';
import 'package:fieldapp/app/modules/dashboard/views/service_tech_home/products_view.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_tech_home_lease_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/controllers/service_tech_home_representative_selector_controller.dart';
import 'package:fieldapp/app/modules/dropdown_selector/views/service_tech_home_company_search_select_view.dart';
import 'package:fieldapp/app/modules/dropdown_selector/views/service_tech_home_leases_search_select_view.dart';
import 'package:fieldapp/app/modules/dropdown_selector/views/service_tech_home_representative_search_select_view.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class ServiceTechHomeView extends GetView<ServiceTechHomeController> {
  const ServiceTechHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ServiceTechRepresentativeSearchSelectView(),
                Get.find<ServiceTechHomeRepresentativeSelectorController>()
                            .selectedRepresentativeName
                            .value !=
                        'Select Representative'
                    ? ServiceTechHomeCompanySearchSelectView()
                    : const SizedBox(),
                ServiceTechHomeLeasesSearchSelectView(),
                Get.find<ServiceTechHomeFormLeaseSelectorController>()
                            .selectedLeaseName
                            .value ==
                        'Select Lease'
                    ? const SizedBox()
                    : const ProductsView(),
                _buildFormViewView(
                    title: 'Service Report',
                    onClick: () {
                      Get.toNamed(Routes.SERVICE_REPORT);
                    }),
                _buildFormViewView(
                    title: 'Analysis Form',
                    onClick: () {
                      Get.toNamed(Routes.ANALYSIS_FORM);
                    }),
              ],
            ),
          ),
          if (controller.apiState.value == APIState.LOADING) const LoaderView(),
        ],
      ),
    );
  }

  Widget _buildFormViewView({title, onClick}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(117, 25, 3, 0.1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.box, height: 24, width: 24),
              const SizedBox(width: 11),
              Text(
                title, // "Service Report",
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    fontFamily: FontFamilyConstants.firasansExtraBold),
              ),
              const Spacer(),
              Center(child: SvgPicture.asset(ImageConstants.rightArrow)),
            ],
          ),
        ),
      ),
    );
  }
}

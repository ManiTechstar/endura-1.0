import 'package:endura_app/app/modules/analysis_form/controllers/analysis_form_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/analysis_form_company_search_select_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/analysis_form_leases_search_select_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/analysis_form_representative_search_select_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/warehouse_search_select_view.dart';
import 'package:endura_app/core/base/views/custom_text_form_field.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AnalysisFormHeaderView extends GetView<AnalysisFormController> {
  const AnalysisFormHeaderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        children: [
          Text(
            ('Header').toUpperCase(),
            style: const TextStyle(
                color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          CustomTextFormField(
            lableText: 'Sampling point *',
            fieldController: controller.samplingPointController,
          ),
          WarehouseSearchSelectView(),
          // RoutesSearchSelectView(),
          AnalysisFormRepresentativeSearchSelectView(),
          (controller.accountRepresentativeSelectorController
                      .selectedRepresentativeName.value !=
                  'Select Representative')
              ? AnalysisFormCompanySearchSelectView()
              : const SizedBox(),
          AnalysisLeasesSearchSelectView(),
          CustomTextFormField(
            lableText: 'City',
            fieldController: controller.cityController,
          ),
          CustomTextFormField(
            lableText: 'Ship to',
            fieldController: controller.shipToController,
          ),
          CustomTextFormField(
            lableText: 'Casing Size (in.)',
            fieldController: controller.casingSizeController,
          ),
          CustomTextFormField(
            lableText: 'Tubing Size (in.)',
            fieldController: controller.tubingSizeController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Rod Size (in.)",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: FontFamilyConstants.firasans),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  lableText: '(in.)',
                  fieldController: controller.rodSizeOneController,
                ),
              ),
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  lableText: '(in.)',
                  fieldController: controller.rodSizeTwoController,
                ),
              ),
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  lableText: '(in.)',
                  fieldController: controller.rodSizeThreeController,
                ),
              ),
            ],
          ),
          CustomTextFormField(
            lableText: 'Depth of Hold (ft.)',
            fieldController: controller.depthOfHoldController,
          ),
          CustomTextFormField(
            lableText: 'Formation',
            fieldController: controller.formationController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Width of Perfs (ft.)",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: FontFamilyConstants.firasans),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  lableText: '(ft.)',
                  fieldController: controller.wopOneController,
                ),
              ),
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  lableText: '(ft.)',
                  fieldController: controller.wopTwoController,
                ),
              ),
            ],
          ),
          CustomTextFormField(
            lableText: 'Standing Fluid Level (ft.)',
            fieldController: controller.sflController,
          ),
          CustomTextFormField(
            lableText: 'Number of Years Produced',
            fieldController: controller.nypController,
          ),
        ],
      ),
    ));
  }
}

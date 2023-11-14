import 'package:fieldapp/app/modules/analysis_form/controllers/analysis_form_controller.dart';
import 'package:fieldapp/core/base/views/custom_text_form_field.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AnalysisFormChemicalsInUseView extends GetView<AnalysisFormController> {
  const AnalysisFormChemicalsInUseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            Text(
              'CHEMICALS IN USE'.toUpperCase(),
              style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            CustomTextFormField(
              lableText: 'Problem Location *',
              fieldController: controller.problemLocatioController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Select Proplem *",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: FontFamilyConstants.firasans),
                ),
              ),
            ),
            _selectProblemCheckBoxes(),
            CustomTextFormField(
              lableText: 'Enter Other',
              fieldController: controller.otherThreeController,
            ),
            _otherThreeCheckboxes(),
            _brandProducts(
                productController: controller.productOrBrandOneController,
                qtyController: controller.qtydOneController),
            _brandProducts(
                productController: controller.productOrBrandTwoController,
                qtyController: controller.qtyTwoController),
            _brandProducts(
                productController: controller.productOrBrandThreeController,
                qtyController: controller.qtyThreeController),
            _getDetailsFieldWidget()
          ],
        ),
      ),
    );
  }

  Widget _brandOrProduct({fieldController, lable}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: fieldController,
        style: TextStyle(
            color: ColorConstants.black1,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: FontFamilyConstants.firasans),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: lable, //"Brand/Product",
          labelStyle: TextStyle(
              color: ColorConstants.black1.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: FontFamilyConstants.firasans),
        ),
      ),
    );
  }

  Widget _brandProducts({productController, qtyController}) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: _brandOrProduct(
              lable: "Brand/Product", fieldController: productController),
        ),
        Flexible(
            flex: 1,
            child: _brandOrProduct(
                lable: 'Qty (GAL)', fieldController: qtyController)),
      ],
    );
  }

  _selectProblemCheckBoxes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          _checkBox(
              title: 'Corrosin',
              icon: controller.isCorrosin.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isCorrosin.value = !controller.isCorrosin.value;
              }),
          _checkBox(
              title: 'Emulsion',
              icon: controller.isEmulsion.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isEmulsion.value = !controller.isEmulsion.value;
              }),
          _checkBox(
              title: 'Reverse',
              icon: controller.isReverse.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isReverse.value = !controller.isReverse.value;
              }),
          _checkBox(
              title: 'Foam',
              icon: controller.isFoam.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isFoam.value = !controller.isFoam.value;
              }),
          _checkBox(
              title: 'Oil Carry Over',
              icon: controller.isOilCarryOver.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isOilCarryOver.value =
                    !controller.isOilCarryOver.value;
              }),
          _checkBox(
              title: 'Paraffin',
              icon: controller.isParaffin.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isParaffin.value = !controller.isParaffin.value;
              }),
          _checkBox(
              title: 'Scale',
              icon: controller.isScale.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isScale.value = !controller.isScale.value;
              }),
          _checkBox(
              title: 'Tank Bottom',
              icon: controller.isTankBottom.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isTankBottom.value = !controller.isTankBottom.value;
              }),
          _checkBox(
              title: 'Iron Sulfide',
              icon: controller.isIronSulfide.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isIronSulfide.value =
                    !controller.isIronSulfide.value;
              }),
          _checkBox(
              title: 'Water Quality',
              icon: controller.isWaterQuality.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isWaterQuality.value =
                    !controller.isWaterQuality.value;
              })
        ],
      ),
    );
  }

  _checkBox({title, icon, onClick}) {
    return InkWell(
      onTap: onClick,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: 25,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  _otherThreeCheckboxes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          _checkBox(
              title: 'SELECT ALL *',
              icon: controller.isSelectAll.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isSelectAll.value = !controller.isSelectAll.value;
                controller.isNeedAnalysis.value = controller.isSelectAll.value;
                controller.isNeedRecommendations.value =
                    controller.isSelectAll.value;
                controller.isSendCopiesToMe.value =
                    controller.isSelectAll.value;
                controller.isSCP.value = controller.isSelectAll.value;
              }),
          _checkBox(
              title: 'NEED ANALYSIS',
              icon: controller.isNeedAnalysis.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isNeedAnalysis.value =
                    !controller.isNeedAnalysis.value;
              }),
          _checkBox(
              title: 'NEED RECOMMENDATIONS',
              icon: controller.isNeedRecommendations.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isNeedRecommendations.value =
                    !controller.isNeedRecommendations.value;
              }),
          _checkBox(
              title: 'SEND ALL COPIES TO ME',
              icon: controller.isSendCopiesToMe.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isSendCopiesToMe.value =
                    !controller.isSendCopiesToMe.value;
              }),
          _checkBox(
              title: 'SEND CUSTOMER COPY',
              icon: controller.isSCP.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isSCP.value = !controller.isSCP.value;
              }),
        ],
      ),
    );
  }

  _getDetailsFieldWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller.detailsController,
        style: TextStyle(
            color: ColorConstants.black1,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: FontFamilyConstants.firasans),
        maxLines: 4,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: "Details",
          labelStyle: TextStyle(
              color: ColorConstants.black1.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: FontFamilyConstants.firasans),
        ),
      ),
    );
  }
}

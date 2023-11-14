import 'package:fieldapp/app/modules/analysis_form/controllers/analysis_form_controller.dart';
import 'package:fieldapp/core/base/views/custom_text_form_field.dart';
import 'package:fieldapp/core/base/views/search_selection_dialog_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AnalysisFormProductionView extends GetView<AnalysisFormController> {
  const AnalysisFormProductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          children: [
            Text(
              ('Production').toUpperCase(),
              style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "FLUIDS",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: FontFamilyConstants.firasans),
                ),
              ),
            ),
            CustomTextFormField(
              lableText: 'Oil (BPD) * ',
              fieldController: controller.oilBPDController,
              onChangeListener: controller.onChangelistener,
            ),
            CustomTextFormField(
              lableText: 'Water (BPD) * ',
              fieldController: controller.waterBPDController,
              onChangeListener: controller.onChangelistener,
            ),
            CustomTextFormField(
              lableText: 'Gas (MCF) * ',
              fieldController: controller.mcfController,
              onChangeListener: controller.onChangelistener,
            ),
            CustomTextFormField(
              lableText: 'Gas (MMCF)',
              fieldController: controller.mmcfController,
              onChangeListener: controller.onChangelistener,
            ),
            CustomTextFormField(
              lableText: 'Gravity',
              fieldController: controller.gravityController,
              onChangeListener: controller.onChangelistener,
            ),
            CustomTextFormField(
              lableText: 'Estimated Chlorides * ',
              fieldController: controller.estimatedChloridesController,
              onChangeListener: controller.onChangelistener,
            ),
            controller.showOtherFields.value
                ? _getRestWidgets()
                : const SizedBox(),
          ],
        ),
      )),
    );
  }

  _selectColoration() {
    return InkWell(
      onTap: () async {
        var item = await Get.dialog(SearchSelectionDialogView(
          items: const ['Green', 'Black', 'Yellow', 'Candensate'],
          searchHint: 'Select Coloration',
          title: 'Coloration',
        ));

        if (item != null) {
          controller.selectedColoration.value = item;
        }
      },
      child: Containers().getSelectorContainer(
        name: controller.selectedColoration.value,
      ),
    );
  }

  _getWellCheckBoxes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          _checkBox(
              title: 'Gas',
              icon: controller.isGas.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isGas.value = !controller.isGas.value;
              }),
          _checkBox(
              title: 'Oil',
              icon: controller.isOil.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isOil.value = !controller.isOil.value;
              }),
          _checkBox(
              title: 'Water',
              icon: controller.isWater.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isWater.value = !controller.isWater.value;
              }),
          _checkBox(
              title: 'Pumping',
              icon: controller.isPumping.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isPumping.value = !controller.isPumping.value;
              }),
          _checkBox(
              title: 'Flowing',
              icon: controller.isFlowing.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isFlowing.value = !controller.isFlowing.value;
              }),
          _checkBox(
              title: 'Inspecion',
              icon: controller.isInspection.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isInspection.value = !controller.isInspection.value;
              }),
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

  _getOtherCheckBoxes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          _checkBox(
              title: 'Gas Lift',
              icon: controller.isGasLift.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isGasLift.value = !controller.isGasLift.value;
              }),
          _checkBox(
              title: 'Hydraulic Lift',
              icon: controller.isHydraulicLift.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isHydraulicLift.value =
                    !controller.isHydraulicLift.value;
              }),
          _checkBox(
              title: 'Beam Pump',
              icon: controller.isBeamPump.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isBeamPump.value = !controller.isBeamPump.value;
              }),
          _checkBox(
              title: 'Koba Pump',
              icon: controller.isKabaPump.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isKabaPump.value = !controller.isKabaPump.value;
              }),
          _checkBox(
              title: 'Reda Pump',
              icon: controller.isRedaPump.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isRedaPump.value = !controller.isRedaPump.value;
              }),
          _checkBox(
              title: 'SWD',
              icon: controller.isSWD.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isSWD.value = !controller.isSWD.value;
              }),
        ],
      ),
    );
  }

  _getEquipmentCheckBoxes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          _checkBox(
              title: 'Separator',
              icon: controller.isSapator.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isSapator.value = !controller.isSapator.value;
              }),
          _checkBox(
              title: 'Heater Treater',
              icon: controller.isHeaterTreater.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isHeaterTreater.value =
                    !controller.isHeaterTreater.value;
              }),
          _checkBox(
              title: 'Stock Tank',
              icon: controller.isStockTank.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isStockTank.value = !controller.isStockTank.value;
              }),
          _checkBox(
              title: 'Fire Water Knockout',
              icon: controller.isFWK.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isFWK.value = !controller.isFWK.value;
              }),
          _checkBox(
              title: 'Pit',
              icon: controller.isPit.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isPit.value = !controller.isPit.value;
              }),
          _checkBox(
              title: 'Gun Barrel',
              icon: controller.isGunBarren.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isGunBarren.value = !controller.isGunBarren.value;
              }),
          _checkBox(
              title: 'Lact',
              icon: controller.isLact.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isLact.value = !controller.isLact.value;
              }),
          _checkBox(
              title: 'Chemelctric',
              icon: controller.isChemelctric.value
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              onClick: () {
                controller.isChemelctric.value =
                    !controller.isChemelctric.value;
              }),
        ],
      ),
    );
  }

  _getRestWidgets() {
    return Column(
      children: [
        _selectColoration(),
        CustomTextFormField(
          lableText: 'Fresh',
          fieldController: controller.freshController,
        ),
        CustomTextFormField(
          lableText: 'Brine',
          fieldController: controller.brineController,
        ),
        CustomTextFormField(
          lableText: 'Woring Pressure',
          fieldController: controller.workingPressureController,
        ),
        CustomTextFormField(
          lableText: 'Shut in',
          fieldController: controller.shutInController,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "WELL :",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: ColorConstants.black1,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: FontFamilyConstants.firasans),
            ),
          ),
        ),
        _getWellCheckBoxes(),
        CustomTextFormField(
          lableText: 'Enter Other',
          fieldController: controller.productioOtherOneController,
        ),
        _getOtherCheckBoxes(),
        CustomTextFormField(
          lableText: 'Enter Other',
          fieldController: controller.productioOtherTwoController,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "EQUIPMENT",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: ColorConstants.black1,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: FontFamilyConstants.firasans),
            ),
          ),
        ),
        _getEquipmentCheckBoxes(),
        CustomTextFormField(
          lableText: 'Eg. 20F',
          fieldController: controller.eg20fController,
        ),
        CustomTextFormField(
          lableText: 'Enter Comments',
          fieldController: controller.commentsController,
        ),
      ],
    );
  }
}

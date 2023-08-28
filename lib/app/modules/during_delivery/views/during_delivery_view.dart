import 'package:endura_app/app/data/model/sub_task_steps_model.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/during_delivery_status_select_view.dart';
import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/constants/image_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../controllers/during_delivery_controller.dart';

class DuringDeliveryView extends GetView<DuringDeliveryController> {
  const DuringDeliveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => controller.status.value != 'Status'
              ? _bottomButtons()
              : const BottomAppBar(
                  height: 0.0,
                ),
        ),
        appBar: BaseAppBar(
          title: 'Delivery',
          hasBackButton: true,
          onBackButtonPressed: () {
            Get.offNamed(Routes.DURING_DELIVERY_TASKS_LIST);
          },
        ),
        body: Obx(
          () => controller.apiState.value == APIState.LOADING
              ? const LoaderView()
              : Timeline(
                  shrinkWrap: true,
                  children: [
                    for (int i = 0;
                        i <
                            controller.deliveryModel.value.result!.subTaskSteps
                                .length;
                        i++)
                      _getSteps(index: i)
                  ],
                ),
        ));
  }

  _getSteps({index}) {
    SubTaskStepData step =
        controller.deliveryModel.value.result!.subTaskSteps[index];
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: TimelineTile(
        nodeAlign: TimelineNodeAlign.start,
        contents: Container(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(children: [
            InkWell(
              onTap: () {
                // controller.expandedIndex.value = index;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      step.stepName!,
                      style: TextStyle(
                          color: ColorConstants.color4,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: FontFamilyConstants.firasansMedium),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16, right: 16),
              padding: const EdgeInsets.only(
                  top: 26, left: 27, bottom: 24, right: 24),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(117, 25, 3, 0.1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(ImageConstants.document,
                          height: 24, width: 24),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Text(
                          step.stepName ?? '',
                          style: TextStyle(
                              color: ColorConstants.black1,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              fontFamily:
                                  FontFamilyConstants.firasansExtraBold),
                        ),
                      ),
                      const Spacer(),
                      if (index !=
                          controller.deliveryModel.value.result!.subTaskSteps
                                  .length -
                              1)
                        _checkBox(
                            icon: controller.selectedSteps.value[index]
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            onClick: () {
                              if (!controller.selectedSteps.value[index]) {
                                controller.selectedSteps.value[index] = true;
                                controller.updateSelectiveSteps(
                                    controller.selectedSteps.value);
                              }
                            })
                    ],
                  ),
                  if (step.safetyCheck != null && step.safetyCheck!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _getSaftyCheckWidget(safetyCheck: step.safetyCheck),
                    )
                  else if (index ==
                          controller.deliveryModel.value.result!.subTaskSteps
                                  .length -
                              1 &&
                      controller.deliveryModel.value.result!.subTaskSteps[index]
                          .products!.isNotEmpty)
                    _showProductsAndStatus(controller.deliveryModel.value
                        .result!.subTaskSteps[index].products!),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (index ==
                          controller.deliveryModel.value.result!.subTaskSteps
                                  .length -
                              1 &&
                      controller.deliveryModel.value.result!.subTaskSteps[index]
                          .products!.isNotEmpty)
                    DuringDeliveryStatusSelectView(index)
                ],
              ),
            )
          ]),
        ),
        node: TimelineNode(
            endConnector: const DashedLineConnector(
              color: Colors.black,
              gap: 6,
              dash: 10,
              thickness: 0.5,
            ),
            startConnector: const DashedLineConnector(
              color: Colors.black,
              gap: 6,
              dash: 10,
              thickness: 0.5,
            ),
            indicatorPosition: 0,
            indicator: ContainerIndicator(
              child: Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.selectedSteps.value[index]
                      ? ColorConstants.black1
                      : Colors.transparent,
                  border: Border.all(
                      color: controller.selectedSteps.value[index]
                          ? ColorConstants.color5
                          : ColorConstants.black1,
                      width: controller.selectedSteps.value[index] ? 3 : 1),
                ),
              ),
            )),
      ),
    );
  }

  _checkBox({icon, onClick}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Icon(
          icon,
          size: 28,
        ),
      ),
    );
  }

  _getSaftyCheckWidget({List<SafetyCheck>? safetyCheck}) {
    List<Widget> checks = [];
    for (var safty in safetyCheck!) {
      checks.add(const SizedBox(
        height: 8.0,
      ));
      checks.add(
        Text(
          safty.stepName!,
          style: TextStyle(
              color: ColorConstants.black1,
              fontWeight: FontWeight.w800,
              fontSize: 16,
              fontFamily: FontFamilyConstants.firasansExtraBold),
        ),
      );
    }
    return checks;
  }

  _showProductsAndStatus(List<Products> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  'Quentity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < products.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    products[i].productId!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: ColorConstants.black1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                Expanded(
                  child: Text(
                    products[i].uomGal!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: ColorConstants.black1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  _bottomButtons() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Containers().loginButtonContainer(
                  color: ColorConstants.color2,
                  text: 'Update TaskStatus',
                  onClick: () {
                    controller.completeTask();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

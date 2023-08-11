import 'package:endura_app/app/data/model/predelivery_steps_model.dart';
import 'package:endura_app/app/modules/dashboard/controllers/driver_home_controller.dart';
import 'package:endura_app/app/modules/login/controllers/login_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/constants/image_constants.dart';
import 'package:endura_app/core/dialogs/views/load_product_dialog_view.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../controllers/predelivery_controller.dart';

class PredeliveryView extends GetView<PredeliveryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(
          title: 'Pre-Delivery',
          hasBackButton: true,
        ),
        body: SafeArea(
          child: Obx(
            () => controller.apiState.value == APIState.LOADING
                ? const LoaderView()
                : Timeline(
                    shrinkWrap: true,
                    children: [
                      for (int i = 0;
                          i < controller.subTaskSteps.value.length;
                          i++)
                        _getSteps(index: i)
                    ],
                  ),
          ),
        ));
  }

  _getSteps({index}) {
    SubTaskSteps step = controller.subTaskSteps.value[index];
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: TimelineTile(
        nodeAlign: TimelineNodeAlign.start,
        contents: Container(
          padding: const EdgeInsets.only(left: 12.0, top: 2.0),
          child: Column(children: [
            InkWell(
              onTap: () {
                controller.expandedIndex.value = index;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.stepName!,
                    style: TextStyle(
                        color: ColorConstants.color4,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: FontFamilyConstants.firasansMedium),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, right: 16),
              padding: const EdgeInsets.only(top: 26, left: 27, right: 24),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(117, 25, 3, 0.1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(ImageConstants.document,
                          height: 24, width: 24),
                      const SizedBox(width: 11),
                      Text(
                        step.stepDescription ?? '',
                        style: TextStyle(
                            color: ColorConstants.black1,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            fontFamily: FontFamilyConstants.firasansExtraBold),
                      ),
                      const Spacer(),
                      (index != controller.subTaskSteps.value.length - 1)
                          ? InkWell(
                              onTap: () {
                                if (!controller
                                    .subTaskSteps.value[index].isSelected!) {
                                  controller.subTaskSteps.value[index]
                                      .isSelected = true;
                                  controller.updateSelectedItem(
                                      items: controller.subTaskSteps.value);
                                }
                              },
                              child: Icon(step.isSelected!
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank),
                            )
                          : const SizedBox()
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (index == controller.subTaskSteps.value.length - 1)
                    Containers().loginButtonContainer(
                        text: controller.productsToLoad.value.isEmpty
                            ? "No Products avaialble"
                            : "Load Products",
                        onClick: () {
                          print('Loadproduct');
                          Get.dialog(LoadProductDialogView(
                            products: controller.productsToLoad.value,
                            yesAction: () {
                              Get.back();
                              controller.completePredelivery(params: {
                                "task_ids": Get.find<DriverHomeController>()
                                    .preDeliveryIds
                                    .value,
                                "user_email": Get.find<LoginController>()
                                    .userModel
                                    .value
                                    .email
                              });
                            },
                          ));
                        }),
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
                  color: step.isSelected!
                      ? ColorConstants.black1
                      : Colors.transparent,
                  border: Border.all(
                      color: step.isSelected!
                          ? ColorConstants.color5
                          : ColorConstants.black1,
                      width: step.isSelected! ? 3 : 1),
                ),
              ),
            )),
      ),
    );
  }
}

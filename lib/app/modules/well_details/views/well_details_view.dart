import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/base_app_bar.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/well_details_controller.dart';

class WellDetailsView extends GetView<WellDetailsController> {
  const WellDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: 'Well Details',
          hasBackButton: true,
          onBackButtonPressed: () {
            Get.back();
          },
        ),
        body: Obx(
          () => Stack(
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' Well Name ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' - ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: Text(
                              controller.welName.value,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' Address ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' - ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' - ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' Latitude ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' - ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: Text(
                              controller.latLongModel.value.result != null &&
                                      controller
                                          .latLongModel.value.result!.isNotEmpty
                                  ? controller.latLongModel.value.result![0] ==
                                          0
                                      ? ' - '
                                      : controller.latLongModel.value.result![0]
                                          .toString()
                                  : ' - ',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' Longitude ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: Get.width,
                            child: const Text(
                              ' - ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: Get.width,
                            child: Text(
                              controller.latLongModel.value.result != null &&
                                      controller
                                          .latLongModel.value.result!.isNotEmpty
                                  ? controller.latLongModel.value.result![1] ==
                                          0
                                      ? ' - '
                                      : controller.latLongModel.value.result![1]
                                          .toString()
                                  : ' - ',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 16.0, color: ColorConstants.color2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    if (controller.latLongModel.value.result != null &&
                        controller.latLongModel.value.result!.isNotEmpty &&
                        controller.latLongModel.value.result![0] != 0 &&
                        controller.latLongModel.value.result![1] != 0)
                      Containers().loginButtonContainer(
                          text: 'View Map',
                          onClick: () {
                            controller.launchGoogleMaps();
                          },
                          color: ColorConstants.black1),
                    Containers().loginButtonContainer(
                        text: 'Update GPS Location',
                        onClick: () {
                          // view confirmation popup
                          controller.getCurrentLocationAndSendToApi();
                        },
                        color: ColorConstants.black1),
                  ],
                ),
              ),
              if (controller.apiState.value == APIState.LOADING)
                const LoaderView()
            ],
          ),
        ));
  }
}

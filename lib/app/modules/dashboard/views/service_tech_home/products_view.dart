import 'dart:convert';

import 'package:endura_app/app/modules/dashboard/controllers/service_tech_home_controller.dart';
import 'package:endura_app/app/modules/dashboard/controllers/service_tech_lease_products_controller.dart';
import 'package:endura_app/app/modules/dashboard/views/service_tech_home/off_target_dialog_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/service_tech_home_lease_selector_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductsView extends GetView<ServiceTechLeaseProductsController> {
  const ProductsView({Key? key}) : super(key: key);

  Widget _noLeaseFound() {
    String leaseName = Get.find<ServiceTechHomeFormLeaseSelectorController>()
        .selectedLeaseName
        .value;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          "No Products found for $leaseName",
          style: TextStyle(
              color: Colors.red.shade800,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: FontFamilyConstants.firasans),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.apiState.value == APIState.LOADING
        ? _getShimmerLoader()
        : controller.model.value.products!.isEmpty
            ? _noLeaseFound()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Continues Injection",
                      style: TextStyle(
                          color: ColorConstants.black1.withOpacity(0.5),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontFamily: FontFamilyConstants.firasansMedium),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child:const Row(
                      children:  [
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
                            'Target Rate',
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
                  for (int i = 0;
                      i < controller.model.value.products!.length;
                      i++)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.model.value.products![i].productId!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: ColorConstants.black1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${controller.model.value.products![i].uomGal!}',
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
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Containers().loginButtonContainer(
                            text: 'Off-Target',
                            onClick: () {
                              Get.dialog(OffTargetDialogView(
                                  yesAction: (updatedProducts) {
                                    Get.find<ServiceTechHomeController>()
                                        .serviceTechTargetApi(updatedProducts);
                                  },
                                  products: controller.model.value.products));
                              // controller.navigateToPreviousPage();
                            }),
                      ),
                      Expanded(
                        child: Containers().loginButtonContainer(
                            text: 'On-Target',
                            onClick: () {
                              Get.find<ServiceTechHomeController>()
                                  .serviceTechTargetApi(
                                      controller.model.value.products!);
                            }),
                      )
                    ],
                  )
                ],
              ));
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
        height: 150.0,
        width: double.infinity,
      ),
    );
  }
}

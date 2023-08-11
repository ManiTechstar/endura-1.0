import 'package:endura_app/app/data/model/cumulative_products_model.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/constants/image_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cummulative_products_controller.dart';

class CummulativeProductsView extends GetView<CumulativeProductsController> {
  const CummulativeProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(controller.apiState.value);
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Products',
        hasBackButton: true,
      ),
      body: Obx(
        () => controller.apiState.value == APIState.COMPLETED
            ? _buildStocks()
            : const LoaderView(),
      ),
    );
  }

  Widget _buildStocks() {
    List<Product> products =
        controller.cumulativeProductsModel.value.products ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
          child: Text(
            "Cumulative products for the day",
            style: TextStyle(
                color: ColorConstants.color4,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                fontFamily: FontFamilyConstants.firasansExtraBold),
          ),
        ),
        Expanded(
          child: products.isEmpty
              ? Center(
                  child: Text(
                    "No products are available",
                    style: TextStyle(
                        color: ColorConstants.black1.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        fontFamily: FontFamilyConstants.mulishExtraBold),
                  ),
                )
              : ListView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 12, left: 16, right: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorConstants.color3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstants.image4,
                              height: 60, width: 60),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Text(
                              products[index].productId!,
                              style: TextStyle(
                                  color: ColorConstants.color4,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  fontFamily:
                                      FontFamilyConstants.firasansExtraBold),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 4),
                            child: Text(
                              "QTY: " +
                                  (products[index].uom_gal ?? "0").toString(),
                              style: TextStyle(
                                  color: ColorConstants.color4,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  fontFamily:
                                      FontFamilyConstants.firasansExtraBold),
                            ),
                          )

                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       margin: const EdgeInsets.only(left: 15, top: 4),
                          //       child: Text(
                          //         (controller.cumulativeProductsModel.value
                          //                     .products![index].productId ??
                          //                 "")
                          //             .toString(),
                          //         style: TextStyle(
                          //             color: ColorConstants.color4,
                          //             fontWeight: FontWeight.w800,
                          //             fontSize: 18,
                          //             fontFamily:
                          //                 FontFamilyConstants.firasansExtraBold),
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: const EdgeInsets.only(left: 15, top: 4),
                          //       child: Text(
                          //         "QTY: " +
                          //             (controller.cumulativeProductsModel.value
                          //                         .products![index].uom_gal ??
                          //                     "0")
                          //                 .toString(),
                          //         style: TextStyle(
                          //             color: ColorConstants.color4,
                          //             fontWeight: FontWeight.w800,
                          //             fontSize: 18,
                          //             fontFamily:
                          //                 FontFamilyConstants.firasansExtraBold),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  }),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}

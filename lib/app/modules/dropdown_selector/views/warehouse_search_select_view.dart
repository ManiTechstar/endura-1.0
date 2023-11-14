// ignore_for_file: must_be_immutable

import 'package:fieldapp/app/modules/dropdown_selector/controllers/warehouse_selector_controller.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/search_selection_dialog_view.dart';
import 'package:fieldapp/core/base/views/search_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WarehouseSearchSelectView
    extends SearchView<WarehouseSelectorController> {
  WarehouseSearchSelectView({Key? key}) : super(key: key);

  @override
  Widget cBuild(BuildContext context, WarehouseSelectorController cController) {
    return Obx(
      () => cController.apiState.value == APIState.LOADING
          ? _getShimmerLoader()
          : InkWell(
              onTap: () async {
                var item = await Get.dialog(SearchSelectionDialogView(
                  items: cController.routes,
                  searchHint: 'Select Warehouse',
                  title: 'Warehouse',
                ));

                if (item != null) {
                  cController.selectedWarehouseName(item);
                }
              },
              child: Containers().getSelectorContainer(
                name: cController.selectedWarehouseName.value,
              ),
            ),
    );
  }
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

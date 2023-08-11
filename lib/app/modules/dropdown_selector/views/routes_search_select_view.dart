import 'package:endura_app/app/modules/dropdown_selector/controllers/routes_selector_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/search_selection_dialog_view.dart';
import 'package:endura_app/core/base/views/search_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RoutesSearchSelectView extends SearchView<RoutesSelectorController> {
  final Function(String)? onSelectRoute;

  RoutesSearchSelectView({Key? key, this.onSelectRoute}) : super(key: key);

  @override
  Widget cBuild(BuildContext context, RoutesSelectorController cController) {
    return Obx(
      () => cController.apiState.value == APIState.LOADING
          ? _getShimmerLoader()
          : InkWell(
              onTap: () async {
                var item = await Get.dialog(SearchSelectionDialogView(
                  items: cController.routes,
                  searchHint: 'Select Route',
                  title: 'Routes',
                ));

                if (item != null) {
                  cController.selectedRouteName(item);
                }

                if (onSelectRoute != null) {
                  onSelectRoute!(item);
                }
              },
              child: Containers().getSelectorContainer(
                name: cController.selectedRouteName.value,
              )),
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

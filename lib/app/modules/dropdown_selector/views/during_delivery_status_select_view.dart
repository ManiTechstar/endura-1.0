import 'package:endura_app/app/data/model/sub_task_steps_model.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/account_representative_selector_controller.dart';
import 'package:endura_app/app/modules/dropdown_selector/controllers/analysis_form_company_selector_controller.dart';
import 'package:endura_app/app/modules/during_delivery/controllers/during_delivery_controller.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/search_selection_dialog_view.dart';
import 'package:endura_app/core/base/views/search_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DuringDeliveryStatusSelectView
    extends SearchView<DuringDeliveryController> {
  int? index = 0;

  DuringDeliveryStatusSelectView(this.index);

  @override
  Widget cBuild(BuildContext context, DuringDeliveryController cController) {
    return Obx(
      () => cController.apiState.value == APIState.LOADING
          ? _getShimmerLoader()
          : InkWell(
              onTap: () async {
                var item = await Get.dialog(SearchSelectionDialogView(
                  items: _getAllNames(),
                  searchHint: 'Update Status',
                  title: 'Task Status',
                  
                ));

                if (item != null) {
                  cController.selectedStatus(item);
                }
              },
              child: Containers().getSelectorContainer(
                name: cController.status.value,
              )),
    );
  }

  _getAllNames() {
    List<String> stepNames = [];
    for (NotTreatedSteps element in cController
        .deliveryModel.value.result!.subTaskSteps[index!].notTreatedSteps!) {
      stepNames.add(element.stepName!);
    }
    return stepNames;
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

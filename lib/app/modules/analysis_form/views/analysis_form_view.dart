import 'package:endura_app/app/modules/analysis_form/views/analysis_form_chemicals_in_use_view.dart';
import 'package:endura_app/app/modules/analysis_form/views/analysis_form_header_view.dart';
import 'package:endura_app/app/modules/analysis_form/views/analysis_form_production_view.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

import '../controllers/analysis_form_controller.dart';

class AnalysisFormView extends GetView<AnalysisFormController> {
  AnalysisFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => _bottomButtons(),
        ),
        appBar: const BaseAppBar(
          title: 'Analysis Form',
          hasBackButton: true,
        ),
        body: SafeArea(
            child: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  NumberStepper(
                    lineColor: Colors.brown,
                    stepColor: Colors.grey,
                    activeStepColor: Colors.brown,
                    numberStyle:
                        const TextStyle(color: Colors.white, fontSize: 12),
                    numbers: const [1, 2, 3],
                    enableStepTapping: false,
                    enableNextPreviousButtons: false,
                    activeStep: controller.index.value,
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        controller.index.value = index;
                      },
                      children: const [
                        AnalysisFormHeaderView(),
                        AnalysisFormProductionView(),
                        AnalysisFormChemicalsInUseView(),
                      ],
                    ),
                  ),
                ],
              ),
              controller.apiState.value == APIState.LOADING
                  ? const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(child: LoaderView()),
                    )
                  : const SizedBox()
            ],
          ),
        )));
  }

  _bottomButtons() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (controller.index.value > 0)
                ? Expanded(
                    child: Containers().loginButtonContainer(
                        text: 'Back',
                        onClick: () {
                          controller.navigateToPreviousPage();
                        }),
                  )
                : const SizedBox(),
            Expanded(
              child: Containers().loginButtonContainer(
                  text: (controller.index.value < 2) ? 'Next' : 'Save',
                  onClick: () {
                    controller.navigateToNextPage();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

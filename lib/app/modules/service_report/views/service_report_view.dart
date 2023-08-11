import 'package:endura_app/app/modules/dropdown_selector/views/service_report_company_search_select_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/service_report_leases_search_select_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/service_report_representative_search_select_view.dart';
import 'package:endura_app/app/modules/dropdown_selector/views/warehouse_search_select_view.dart';
import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:endura_app/core/base/views/base_app_bar.dart';
import 'package:endura_app/core/base/views/custom_text_form_field.dart';
import 'package:endura_app/core/base/views/loader_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/util_widgets/selector_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_report_controller.dart';

class ServiceReportView extends GetView<ServiceReportController> {
  const ServiceReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Service Report',
        onBackButtonPressed: () {
          Get.back();
        },
        hasBackButton: true,
      ),
      body: SafeArea(child: Obx(() {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      WarehouseSearchSelectView(),
                      ServiceReportRepresentativeSearchSelectView(),
                      (controller.accountRepresentativeSelectorController
                                  .selectedRepresentativeName.value !=
                              'Select Representative')
                          ? ServiceReportCompanySearchSelectView()
                          : const SizedBox(),
                      ServiceReportLeasesSearchSelectView(),
                      CustomTextFormField(
                          fieldController: controller.countyContoller,
                          lableText: 'Enter County *'),
                      CustomTextFormField(
                          fieldController: controller.boalController,
                          lableText: 'Enter BOAL'),
                      CustomTextFormField(
                          fieldController: controller.rateController,
                          lableText: 'Enter RATE'),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(117, 25, 3, 0.1)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "S.O.A.R",
                                  style: TextStyle(
                                      color: ColorConstants.black1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: FontFamilyConstants.firasans),
                                ),
                                CupertinoSwitch(
                                  trackColor: Colors.grey,
                                  value: controller.mainSoar.value,
                                  activeColor: Colors.brown,
                                  onChanged: (newValue) {
                                    controller.mainSoar.value =
                                        !controller.mainSoar.value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      controller.nameControllers.isNotEmpty ||
                              (controller.rate.value.isNotEmpty &&
                                  controller.soar.value.isNotEmpty)
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(117, 25, 3, 0.1)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: _buildGrid(),
                              ),
                            )
                          : const SizedBox(),
                      CustomTextFormField(
                          fieldController: controller.specialTreatController,
                          lableText: 'Enter Special Treat'),
                      CustomTextFormField(
                          fieldController: controller.notesController,
                          lableText: 'Enter Notes'),
                      const SizedBox(height: 10),
                      Containers().loginButtonContainer(
                          text: 'Save',
                          onClick: () {
                            controller.submitServiceReport();
                          })
                    ],
                  ),
                )),
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
        );
      })),
    );
  }

  Widget _buildGrid() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8, left: 1, right: 1),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chemicals",
                    style: TextStyle(
                        color: ColorConstants.black1,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: FontFamilyConstants.firasans),
                  ),
                  InkWell(
                    onTap: () {
                      controller.addNewEmptyProduct();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add New",
                        style: TextStyle(
                            color: ColorConstants.black1,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: FontFamilyConstants.firasans),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        controller.soar.value.isNotEmpty
            ? _getProductsListWidget()
            : const SizedBox()
      ],
    );
  }

  Widget _getProductsListWidget() {
    return ListView.builder(
        itemCount: controller.rate.value.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 1, right: 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                textColor: Colors.brown,
                iconColor: Colors.brown,
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.removeProductFromList(index);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        child: Icon(
                          Icons.delete,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sr. No. " + (index + 1).toString(),
                        style: TextStyle(
                            color: ColorConstants.black1,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: FontFamilyConstants.firasans),
                      ),
                    ),
                  ],
                ),
                children: [
                  _productsContainer(
                      lable: 'Enter Name',
                      controller: controller.nameControllers[index]),
                  _productsContainer(
                      lable: 'Enter Gallons Deliveried',
                      controller:
                          controller.gallonsDeliveredControllers[index]),
                  _productsContainer(
                      lable: 'Enter Gallons On Hand',
                      controller: controller.gallonsOnHandControllers[index]),
                  _productsContainer(
                      lable: 'REC. RATE',
                      controller: controller.recRateControllers[index]),
                  _productsContainer(
                      lable: 'Enter Actual Rate',
                      controller: controller.actualRateControllers[index]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          List<bool> vals = controller.rate.value;
                          controller.rate.value = [];
                          vals[index] = !vals[index];
                          controller.rate.value.addAll(vals);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(!controller.rate.value[index]
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box_outlined),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Rate",
                                  style: TextStyle(
                                      color: ColorConstants.black1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: FontFamilyConstants.firasans),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          List<bool> vals = controller.soar.value;
                          controller.soar.value = [];
                          vals[index] = !vals[index];
                          controller.soar.value.addAll(vals);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(!controller.soar.value[index]
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box_outlined),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "S.O.A.R",
                                  style: TextStyle(
                                      color: ColorConstants.black1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily: FontFamilyConstants.firasans),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _productsContainer(
                      lable: 'Enter Comments',
                      controller: controller.commentsControllers.value[index]),
                ],
              ),
            ),
          );
        });
  }

  Widget _productsContainer({lable, controller}) {
    return Container(
      margin: const EdgeInsets.only(left: 1, right: 1, bottom: 16, top: 1),
      child: TextFormField(
        controller: controller, //controller.nameControllers[index],
        style: TextStyle(
            color: ColorConstants.black1,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: FontFamilyConstants.firasans),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: lable, //"Enter NAME",
          labelStyle: TextStyle(
              color: ColorConstants.black1.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: FontFamilyConstants.firasans),
        ),
      ),
    );
  }
}

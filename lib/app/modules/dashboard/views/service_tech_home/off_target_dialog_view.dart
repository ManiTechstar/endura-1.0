// ignore_for_file: must_be_immutable

import 'package:fieldapp/app/data/model/products_by_well_model.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffTargetDialogView extends GetView {
  OffTargetDialogView({this.yesAction, Key? key, this.products})
      : super(key: key);
  Function(List<Products>)? yesAction;
  List<Products>? products;

  List<TextEditingController>? controllers = [];

  List<TextEditingController>? commentsControllers = [];

  @override
  Widget build(BuildContext context) {
    _getAllControllers();
    return Dialog(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_header(), _body(), _actionButtons(yesAction: yesAction)]),
    );
  }

  _header() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      color: ColorConstants.black1,
      child: const Text(
        'Action',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _body() {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          products![index].productId!,
                          style: TextStyle(
                              color: ColorConstants.black1.withOpacity(0.5),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: FontFamilyConstants.firasansMedium),
                        ),
                      ),
                      TextField(
                        controller: controllers![index],
                        onChanged: (value) {
                          products![index].uomGal = double.parse(value);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        style: TextStyle(
                            color: ColorConstants.black1,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: FontFamilyConstants.firasans),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(117, 25, 3, 0.13)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(117, 25, 3, 0.13)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 24, top: 28, bottom: 28),
                          hintText: 'Target Rate',
                          hintStyle: TextStyle(
                              color: ColorConstants.black1.withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: FontFamilyConstants.firasans),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: commentsControllers![index],
                        maxLines: 5,
                        onChanged: (value) {
                          products![index].uomGal = double.parse(value);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        style: TextStyle(
                            color: ColorConstants.black1,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: FontFamilyConstants.firasans),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(117, 25, 3, 0.13)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(117, 25, 3, 0.13)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 24, top: 28, bottom: 28),
                          hintText: 'Comments',
                          hintStyle: TextStyle(
                              color: ColorConstants.black1.withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: FontFamilyConstants.firasans),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }

  _actionButtons({yesAction}) {
    return Containers().loginButtonContainer(
        text: 'Inject',
        onClick: () {
          print('Inject clicked');
          Get.back();
          yesAction(products);
        });
  }

  void _getAllControllers() {
    if (products!.isNotEmpty) {
      products!.forEach((element) {
        controllers!.add(TextEditingController());
        commentsControllers!.add(TextEditingController());
      });
    }
  }
}

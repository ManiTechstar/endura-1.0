import 'package:fieldapp/app/data/model/predelivery_steps_model.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/utilities/date_utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoadProductDialogView extends GetView {
  LoadProductDialogView({this.yesAction, this.products, Key? key})
      : super(key: key);
  Function()? yesAction;

  List<Products>? products;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _header(),
        Container(
          width: double.infinity,
          height: 1.0,
          color: ColorConstants.black1,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: Text(
                  'Quantity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: ColorConstants.black1,
        ),
        _body(),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: ColorConstants.black1,
        ),
        _actionButtons(
          yesAction: yesAction,
        )
      ]),
    );
  }

  _header() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      width: double.infinity,
      color: ColorConstants.black1,
      child: Text(
        DateUtility().getToday(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _body() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300.0,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: products!.length,
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(products![index].productId!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: ColorConstants.black1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                ),
                Expanded(
                  flex: 1,
                  child: Text(products![index].uomGal!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: ColorConstants.black1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  _actionButtons({
    yesAction,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: yesAction,
            child: Container(
                padding: const EdgeInsets.all(12.0),
                color: ColorConstants.black1,
                child: const Text(
                  'Yes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                )),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                'No',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
              ),
            ),
          ),
        )
      ],
    );
  }
}

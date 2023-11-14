import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ActionDialogView extends GetView {
  String title;
  String yesButtonText;
  String noButtonText;

  ActionDialogView(
      {this.yesAction,
      this.title = 'Action',
      this.yesButtonText = 'Yes',
      this.noButtonText = 'No',
      this.message,
      this.noAction,
      Key? key})
      : super(key: key);
  Function()? yesAction;
  Function()? noAction;

  String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _header(),
        _body(),
        Container(
          width: double.infinity,
          height: 1.0,
          color: ColorConstants.black1,
        ),
        _actionButtons(yesAction: yesAction, noAction: noAction)
      ]),
    );
  }

  _header() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      color: ColorConstants.black1,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _body() {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          message!,
          style: const TextStyle(
              color: ColorConstants.black1,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ));
  }

  _actionButtons({yesAction, noAction}) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: yesAction,
              child: Container(
                  padding: const EdgeInsets.all(12.0),
                  color: ColorConstants.black1,
                  child: Text(
                    yesButtonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14),
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: noAction,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  noButtonText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ColorConstants.black1,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

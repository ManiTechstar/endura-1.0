import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseView<T extends BaseController> extends GetView {
  Widget child;
  T controller;
  BaseView(this.child, this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        child,
        controller.apiState.value == APIState.LOADING
            ? LoaderView()
            : SizedBox()
      ]),
    );
  }
}

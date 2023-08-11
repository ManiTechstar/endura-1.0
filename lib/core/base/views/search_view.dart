import 'package:endura_app/core/base/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SearchView<T extends BaseController> extends GetView {
  SearchView({Key? key}) : super(key: key);

  late T cController;
  @override
  Widget build(BuildContext context) {
    cController = Get.find<T>();
    return cBuild(context, cController);
  }

  Widget cBuild(BuildContext context, T cController);
}

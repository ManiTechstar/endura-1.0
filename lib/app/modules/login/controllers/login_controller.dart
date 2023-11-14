import 'dart:convert';

import 'package:fieldapp/app/data/model/user_model.dart';
import 'package:fieldapp/app/providers/login_service_provider.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/utilities/shared_preferance_helper.dart';
import 'package:fieldapp/core/utilities/snackbar_supporter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginController extends BaseController {
  final userModel = UserModel().obs;

  final showPassword = false.obs;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  login({params}) async {
    if (formKey.currentState!.validate()) {
      bool isInternetConnected = await isInternetAvailable();
      if (isInternetConnected) {
        apiState.value = APIState.LOADING;
        try {
          UserModel model = await LoginServiceProvider().login(params: {
            "email": emailController.text,
            "password": passwordController.text
          });
          if (model != null) {
            userModel(model);
            SnackbarSupporter.showSuccessSnackbar(
                title: 'Success', message: 'Login Success');

            Get.offAllNamed(Routes.DASHBOARD);
          }
          apiState.value = APIState.COMPLETED;
        } catch (e) {
          SnackbarSupporter.showFailureSnackbar(
              title: 'Error', message: e.toString());

          apiState.value = APIState.COMPLETED;
        }
      } else {
        SnackbarSupporter.showFailureSnackbar(
            title: 'Connectivity Exception',
            message: 'Please check your network');
      }
    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    checkUserDataAvailable();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showPwd() {
    showPassword.value = !showPassword.value;
  }

  void checkUserDataAvailable() async {
    var user = await SharedPreferanceHelper().getSharedPrefString(key: 'user');
    userModel(UserModel.fromJson(jsonDecode(user!)));
  }
}

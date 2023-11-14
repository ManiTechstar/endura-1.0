import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/constants/image_constants.dart';
import 'package:fieldapp/core/constants/strings_constants.dart';
import 'package:fieldapp/core/util_widgets/selector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Containers().loginButtonContainer(
          text: 'Login',
          onClick: () {
            controller.login(params: {});
          },
        ),
        body: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogo(),
                      _buildHeader(),
                      _buildTextFields(),
                      _buildForgotPassword(),
                    ],
                  ),
                ),
                controller.apiState.value == APIState.LOADING
                    ? const LoaderView()
                    : const SizedBox()
              ],
            ),
          ),
        ));
  }

  Widget _buildLogo() {
    return Container(
      height: 34,
      width: 111,
      margin: const EdgeInsets.only(left: 16),
      child: Image.asset(ImageConstants.enduraLogo),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 16, top: 49),
            child: Text(
              Strings.helloWelcome,
              style: TextStyle(
                  color: ColorConstants.black1,
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  fontFamily: FontFamilyConstants.firasansExtraBold),
            )),
        Container(
            margin: const EdgeInsets.only(left: 16, top: 24),
            child: Text(
              Strings.loginAccount,
              style: TextStyle(
                  color: ColorConstants.black1.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  fontFamily: FontFamilyConstants.firasans),
            )),
      ],
    );
  }

  Widget _buildTextFields() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 64, right: 16),
            child: TextFormField(
              controller: controller.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter EmailId or EmployeeId';
                }
                return null;
              },
              style: TextStyle(
                  color: ColorConstants.black1,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: FontFamilyConstants.firasans),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
                  borderRadius: BorderRadius.circular(16),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding:
                    const EdgeInsets.only(left: 24, top: 28, bottom: 28),
                hintText: Strings.emailId,
                hintStyle: TextStyle(
                    color: ColorConstants.black1.withOpacity(0.3),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: FontFamilyConstants.firasans),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 16, top: 12, right: 16),
              child: TextFormField(
                controller: controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: !controller.showPassword.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: FontFamilyConstants.firasans),
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.showPwd();
                    },
                    child: Icon(
                      !controller.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: controller.showPassword.value
                          ? ColorConstants.black1
                          : ColorConstants.black1.withOpacity(0.3),
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.only(left: 24, top: 28, bottom: 28),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(117, 25, 3, 0.13)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: Strings.password,
                  hintStyle: TextStyle(
                      color: ColorConstants.black1.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: FontFamilyConstants.firasans),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 24),
      child: Row(
        children: [
          Text(
            Strings.forgotPassword,
            style: TextStyle(
                color: ColorConstants.black1.withOpacity(0.5),
                fontWeight: FontWeight.w700,
                fontSize: 14,
                fontFamily: FontFamilyConstants.firasans),
          ),
          const SizedBox(width: 12),
          SvgPicture.asset(ImageConstants.rightArrow),
          const SizedBox(width: 8),
          Text(
            Strings.reset,
            style: TextStyle(
                color: ColorConstants.black1,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                decoration: TextDecoration.underline,
                fontFamily: FontFamilyConstants.firasans),
          ),
        ],
      ),
    );
  }
}

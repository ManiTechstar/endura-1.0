import 'package:fieldapp/app/modules/login/controllers/login_controller.dart';
import 'package:fieldapp/app/routes/app_pages.dart';
import 'package:fieldapp/core/base/controllers/base_controller.dart';
import 'package:fieldapp/core/base/views/loader_view.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/constants/image_constants.dart';
import 'package:fieldapp/core/utilities/shared_preferance_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileView extends GetView<LoginController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 34),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        color: ColorConstants.black1,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: FontFamilyConstants.mulishExtraBold),
                  ),
                ),
                const SizedBox(height: 52),
                _buildProfile(),
              ],
            ),
            controller.apiState.value == APIState.LOADING
                ? const LoaderView()
                : const SizedBox()
          ],
        ),
      )),
    );
  }

  Widget _buildProfile() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(ImageConstants.doc1),
          ),
          const SizedBox(height: 9),
          Text(
            (controller.userModel.value.name ?? ""),
            style: TextStyle(
                color: ColorConstants.black1,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                fontFamily: FontFamilyConstants.firasansExtraBold),
          ),
          const SizedBox(height: 9),
          Text(
            (controller.userModel.value.email ?? ""),
            style: TextStyle(
                color: ColorConstants.black1,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                fontFamily: FontFamilyConstants.firasansExtraBold),
          ),
          const SizedBox(height: 9),
          Text(
            (controller.userModel.value.role ?? ""),
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: FontFamilyConstants.firasansMedium),
          ),
          const SizedBox(height: 70),
          InkWell(
            onTap: () async {
              controller.apiState.value = APIState.LOADING;
              Future.delayed(const Duration(milliseconds: 1500), () {
                SharedPreferanceHelper().clearAllThePrefData();
                controller.apiState.value = APIState.COMPLETED;
                Get.offAllNamed(Routes.LOGIN);
              });
            },
            child: Text(
              "Log Out",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: FontFamilyConstants.firasansMedium),
            ),
          ),
        ],
      ),
    );
  }
}

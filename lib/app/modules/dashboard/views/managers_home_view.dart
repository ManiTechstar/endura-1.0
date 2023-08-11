import 'package:endura_app/app/routes/app_pages.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class ManagersHomeView extends GetView {
  const ManagersHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildFormViewView(
              title: 'Service Report',
              onClick: () {
                Get.toNamed(Routes.SERVICE_REPORT);
              }),
          _buildFormViewView(
              title: 'Analysis Form',
              onClick: () {
                Get.toNamed(Routes.ANALYSIS_FORM);
              }),
        ],
      ),
    );
  }

  Widget _buildFormViewView({title, onClick}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(117, 25, 3, 0.1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.box, height: 24, width: 24),
              const SizedBox(width: 11),
              Text(
                title, // "Service Report",
                style: TextStyle(
                    color: ColorConstants.black1,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    fontFamily: FontFamilyConstants.firasansExtraBold),
              ),
              const Spacer(),
              Center(child: SvgPicture.asset(ImageConstants.rightArrow)),
            ],
          ),
        ),
      ),
    );
  }
}

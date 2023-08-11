import 'package:endura_app/app/modules/dashboard/views/home_view.dart';
import 'package:endura_app/app/modules/dashboard/views/profile_view.dart';
import 'package:endura_app/core/constants/color_constants.dart';
import 'package:endura_app/core/constants/font_family_constants.dart';
import 'package:endura_app/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: <Widget>[
                  HomeView(),
                  ProfileView(),
                ],
              )),
        ),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            child: Container(
              height: 75,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top:
                          BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)))),
              child: TabBar(
                onTap: (index) {
                  controller.updateIndex(index);
                },
                indicator: const BoxDecoration(),
                tabs: <Widget>[
                  Tab(
                      child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            controller.currentIndex.value == 0
                                ? ImageConstants.homeFilled
                                : ImageConstants.homeOutline,
                            color: controller.currentIndex.value == 0
                                ? ColorConstants.color2
                                : ColorConstants.color2.withOpacity(0.5)),
                        const SizedBox(height: 8),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: controller.currentIndex.value == 0
                                  ? ColorConstants.black1
                                  : ColorConstants.black1.withOpacity(0.5),
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              fontFamily:
                                  FontFamilyConstants.firasansExtraBold),
                        ),
                      ],
                    ),
                  )),
                  Tab(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          controller.currentIndex.value == 1
                              ? ImageConstants.profileFilled
                              : ImageConstants.profile,
                          color: ColorConstants.color2),
                      const SizedBox(height: 9),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: controller.currentIndex.value == 1
                                ? ColorConstants.black1
                                : ColorConstants.black1.withOpacity(0.5),
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            fontFamily: FontFamilyConstants.firasansExtraBold),
                      ),
                    ],
                  )),
                ],
                controller: controller.tabController,
              ),
            ),
          ),
        ));
  }
}

import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BaseAppBar extends GetWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final List<Widget>? actions;
  final void Function()? onBackButtonPressed;

  const BaseAppBar(
      {Key? key,
      required this.title,
      this.hasBackButton = false,
      this.onBackButtonPressed,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      actions: actions,
      title: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          title,
          style: TextStyle(
              color: ColorConstants.black1,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: FontFamilyConstants.mulishExtraBold),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: hasBackButton
          ? InkWell(
              onTap: onBackButtonPressed ?? () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(left: 8.0, top: 5.0),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: ColorConstants.color2.withOpacity(0.13))),
                child: SvgPicture.asset(ImageConstants.leftArrow,
                    color: ColorConstants.color4),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

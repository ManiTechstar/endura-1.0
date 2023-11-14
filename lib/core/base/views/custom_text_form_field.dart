import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends GetWidget {
  var width;
  Function(String)? onChangeListener;

  CustomTextFormField(
      {Key? key,
      this.fieldController,
      this.lableText,
      this.width = double.infinity,
      this.onChangeListener})
      : super(key: key);

  String? lableText;
  TextEditingController? fieldController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: fieldController,
        onChanged: onChangeListener,
        style: TextStyle(
            color: ColorConstants.black1,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: FontFamilyConstants.firasans),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(117, 25, 3, 0.13)),
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: lableText,
          labelStyle: TextStyle(
              color: ColorConstants.black1.withOpacity(0.6),
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: FontFamilyConstants.firasans),
        ),
      ),
    );
  }
}

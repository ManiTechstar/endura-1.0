import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Containers {
  Widget getSelectorContainer({name}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          border: Border.all(
            color: ColorConstants.black1,
            width: 1,
          )),
      child: Row(
        children: [
          Text(name!),
          const Spacer(),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  Widget loginButtonContainer(
      {text, onClick, Color color = ColorConstants.color2}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 21),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: InkWell(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: color,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 0.48,
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: FontFamilyConstants.firasansExtraBold,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

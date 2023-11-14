import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
            color: ColorConstants.black1.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: const SpinKitDoubleBounce(
          color: ColorConstants.black1,
          size: 50.0,
        ),
      ),
    );
    ;
  }
}

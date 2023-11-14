import 'package:fieldapp/app/data/model/open_tasks_list_model.dart';
import 'package:fieldapp/core/constants/color_constants.dart';
import 'package:fieldapp/core/constants/font_family_constants.dart';
import 'package:fieldapp/core/utilities/date_utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TaskDetailsDialogView extends GetView {
  TaskDetailsDialogView(
      {this.assignToYourSelf,
      this.task,
      this.actionTitle = 'Assign To Yourself',
      this.hasActionButton = true,
      Key? key})
      : super(key: key);
  Function()? assignToYourSelf;

  var task;
  String actionTitle;
  bool hasActionButton;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _header(),
        _body(),
        Container(
          width: double.infinity,
          height: 1.0,
          color: ColorConstants.black1,
        ),
      ]),
    );
  }

  _header() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      color: ColorConstants.black1,
      child: const Text(
        'Task Details',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          _getRowItem(title: 'Task', value: task!.taskName),
          const SizedBox(height: 5),
          _getRowItem(title: 'Well', value: task!.leaseLocation),
          const SizedBox(height: 5),
          _getRowItem(title: 'Location', value: task!.location!.address),
          const SizedBox(height: 5),
          _getRowItem(title: 'Customer', value: task!.customerName),
          const SizedBox(height: 5),
          _getRowItem(title: 'Status', value: task.taskStatus),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateUtility()
                    .getStartDateFormate(date: task!.startDate.toString()),
                style: TextStyle(
                    color: ColorConstants.black1.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: FontFamilyConstants.mulishExtraBold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (hasActionButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: assignToYourSelf,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 15, right: 15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: ColorConstants.color2),
                    child: Text(
                      actionTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 0.25,
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: FontFamilyConstants.firasansExtraBold,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  _getRowItem({title, value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ColorConstants.black1.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: FontFamilyConstants.mulishExtraBold),
            ),
          ),
        ),
        Text(
          "-   ",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: ColorConstants.black1.withOpacity(0.7),
              fontWeight: FontWeight.w500,
              fontSize: 15,
              fontFamily: FontFamilyConstants.mulishExtraBold),
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: ColorConstants.black1.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: FontFamilyConstants.mulishExtraBold),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarSupporter {
  static showSuccessSnackbar({title, message}) => Get.snackbar(title, message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
  static showFailureSnackbar({title, message}) => Get.snackbar(title, message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}

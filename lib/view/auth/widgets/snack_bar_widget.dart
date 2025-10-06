import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBarWidget({String? status, String? msg, Color? color}) {
  Get.snackbar(
    status ?? "",
    msg ?? "",
    backgroundColor: color,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}

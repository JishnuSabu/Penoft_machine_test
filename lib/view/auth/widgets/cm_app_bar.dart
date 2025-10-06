import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget cmBackWidget() {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: Row(
      children: [
        Icon(Icons.arrow_back_ios, size: 16.sp),
        Text(
          "Back",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  );
}

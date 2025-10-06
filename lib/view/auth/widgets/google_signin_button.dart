import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget googleSigninButton(BuildContext context) {
  final AuthController authController = Get.find<AuthController>();
  return Container(
    width: 327.w,
    height: 48.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
    ),
    child: ElevatedButton(
      onPressed: () {
        authController.signInWithGoogle();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/google.svg',
            width: 20.w,
            height: 20.w,
            placeholderBuilder: (context) =>
                Icon(Icons.g_mobiledata, size: 20.w, color: Colors.red),
          ),
          sizedBoxW10,
          Text(
            'Continue with Google',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    ),
  );
}

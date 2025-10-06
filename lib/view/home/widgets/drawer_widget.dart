import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final AuthController authController = Get.put(AuthController());
Widget drawer() {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFF7C3AED)),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text(
            "Logout",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () async {
            await authController.clearToken();
          },
        ),
      ],
    ),
  );
}

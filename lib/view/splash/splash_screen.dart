import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/splash_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    authController.checkToken();
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 182.w,
          width: 285.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              splashCard(),
              sizedBoxH24,
              const Text(
                "educatory",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "InterTight",
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 52,
                  height: 20 / 52,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

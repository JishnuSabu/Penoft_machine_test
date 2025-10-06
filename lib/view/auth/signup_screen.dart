import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_app_bar.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_elevated_button.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_text_field.dart';
import 'package:flutter_application_1/view/auth/widgets/google_signin_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: screenWidth,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxH15,
                cmBackWidget(),
                sizedBoxH24,
                Text(
                  "Enter your email",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                sizedBoxH05,
                Text(
                  "Enter your email to receive verification code",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: const Color(0xFF475569),
                  ),
                ),
                sizedBoxH24,
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                sizedBoxH05,
                CmTextField(
                  controller: authController.signupEmailController,
                  hintText: "email",
                  prefixIcon: Icons.mail_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email cannot be empty';
                    }
                    final emailRegex = RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                sizedBoxH15,
                Obx(
                  () => CustomElevatedButton(
                    text: "Continue",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.requestOtp();
                      }
                    },
                    isLoading: authController.isLoading.value,
                  ),
                ),
                sizedBoxH24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xFF9F54F8),
                      ),
                    ),
                  ],
                ),
                sizedBoxH24,
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: const Color(0xFFCBD5E1),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: const Color(0xFFCBD5E1),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                sizedBoxH24,
                googleSigninButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// view/auth/verification_code_screen.dart (Alternative reactive version)
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_app_bar.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_elevated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxH15,
              cmBackWidget(),
              sizedBoxH35,
              Text(
                "Enter verification code",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              sizedBoxH10,
              Text(
                "Enter the verification code sent to",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Color(0XFF475569),
                ),
              ),
              Obx(
                () => Text(
                  authController.signupEmail.value != ""
                      ? authController.signupEmail.value
                      : "mail id",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xFF9F54F8),
                  ),
                ),
              ),

              sizedBoxH24,
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: authController.otpController,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,

                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12.r),
                  fieldHeight: 48.w,
                  fieldWidth: 48.w,
                  activeFillColor: Color(0xFFFFFFFF),
                  selectedFillColor: Color(0xFFFFFFFF),
                  inactiveFillColor: Color(0xFFFFFFFF),
                  activeColor: const Color(0xFF9F54F8),
                  selectedColor: const Color(0xFFCBD5E1),
                  inactiveColor: const Color(0xFFCBD5E1),
                ),
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
                enableActiveFill: true,
                hintCharacter: "_",
                hintStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF0F172A),
                ),
                onCompleted: authController.verifyOtp,
                onChanged: (value) {},
              ),
              sizedBoxH24,

              Obx(
                () => CustomElevatedButton(
                  text: authController.isLoading.value
                      ? "Verifying..."
                      : "Continue",
                  onPressed: authController.isLoading.value
                      ? null
                      : () => authController.verifyOtp(
                          authController.otpController.text,
                        ),
                ),
              ),
              sizedBoxH24,
              Center(
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      InkWell(
                        onTap: authController.canResend.value
                            ? authController.resendOtp
                            : null,
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF9F54F8),
                          ),
                        ),
                      ),
                      Text(
                        " in ${authController.resendTimer.value} seconds",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

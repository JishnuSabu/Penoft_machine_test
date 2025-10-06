import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_app_bar.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_elevated_button.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNameScreen extends StatelessWidget {
  AddNameScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxH15,
              cmBackWidget(),
              sizedBoxH24,
              Text(
                "What's your name",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              sizedBoxH24,
              Text(
                "Full Name",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              sizedBoxH05,

              Form(
                key: _formKey,
                child: CmTextField(
                  controller: authController.addFullNameController,
                  hintText: "Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
              ),

              sizedBoxH15,
              Obx(
                () => CustomElevatedButton(
                  text: "Continue",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      authController.addFullName();
                    }
                  },
                  isLoading: authController.isAddNameLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

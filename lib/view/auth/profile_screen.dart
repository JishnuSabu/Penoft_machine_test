import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/auth_successfull_screen.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_app_bar.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_elevated_button.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_image_picker_widget.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool fromGoogle = Get.arguments?['fromGoogle'] ?? false;
    final String initialName = authController.fetchedNameController.text.trim();
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: screenWidth,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBoxH15,
                  cmBackWidget(),
                  sizedBoxH35,
                  Text(
                    "Your Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  sizedBoxH10,
                  Text(
                    "If needed you can change the details by clicking on them",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  sizedBoxH35,
                  Text(
                    "Profile Picture",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  sizedBoxH05,
                  imagePickerWidget(authController),
                  sizedBoxH18,
                  Text(
                    "Full Name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  sizedBoxH05,
                  CmTextField(
                    controller: authController.fetchedNameController,
                    hintText: "name",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Full name cannot be empty";
                      }
                      if (value.trim().length < 3) {
                        return "Full name must be at least 3 characters";
                      }
                      return null;
                    },
                  ),
                  sizedBoxH18,
                  Text(
                    "Mail Id",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  sizedBoxH05,
                  CmTextField(
                    controller: authController.fetchedMailIdController,
                    hintText: "mail id",
                    readOnly: true,
                  ),
                  if (fromGoogle) ...[
                    sizedBoxH18,
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    sizedBoxH05,
                    CmTextField(
                      controller: authController.fetchedPhNoController,
                      hintText: "Ph No",
                    ),
                  ],
                  sizedBoxH18,
                  CustomElevatedButton(
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final currentName = authController
                            .fetchedNameController
                            .text
                            .trim();

                        if (currentName != initialName) {
                          await authController.addFullName(navigate: false);
                        }
                        if (fromGoogle) {
                          await authController.createUser();
                        } else {
                          Get.offAll(() => AuthSuccessfullScreen());
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

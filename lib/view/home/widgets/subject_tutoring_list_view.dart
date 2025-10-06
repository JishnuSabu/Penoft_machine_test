import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homecontroller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubjectTutoringListView extends StatelessWidget {
  SubjectTutoringListView({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 80.w,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: homeController.subjects.length,
          itemBuilder: (context, index) {
            final subject = homeController.subjects[index];
            String iconUrl = subject.icon;
            if (!iconUrl.endsWith('.png')) {
              iconUrl = '$iconUrl.png';
            }

            return Container(
              width: 159.w,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    homeController.hexToColor(subject.mainColor),
                    homeController.hexToColor(subject.gradientColor),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subject.icon.isNotEmpty
                            ? Image.network(
                                iconUrl,
                                fit: BoxFit.contain,
                                width: 28.16.w,
                                height: 26.87.w,
                                color: Color(0xFFFFFFFF),
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.book,
                                    color: Colors.white,
                                    size: 32,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.book,
                                color: Colors.white,
                                size: 32,
                              ),
                        const Spacer(),
                        Text(
                          subject.subject,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

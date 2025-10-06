import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homecontroller.dart';
import 'package:flutter_application_1/view/home/widgets/course_card_widget.dart';
import 'package:get/get.dart';

class AllCoursesListView extends StatelessWidget {
  AllCoursesListView({super.key});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isCoursesLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: CircularProgressIndicator(),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: homeController.courses.length,
        itemBuilder: (context, index) {
          final course = homeController.courses[index];

          return CourseCard(course: course);
        },
      );
    });
  }
}

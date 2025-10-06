import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homecontroller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_text_field.dart';
import 'package:flutter_application_1/view/home/widgets/all_courses_list_view.dart';
import 'package:flutter_application_1/view/home/widgets/banner_widget.dart';
import 'package:flutter_application_1/view/home/widgets/drawer_widget.dart';
import 'package:flutter_application_1/view/home/widgets/materials_list_view.dart';
import 'package:flutter_application_1/view/home/widgets/subject_tutoring_list_view.dart';
import 'package:flutter_application_1/view/home/widgets/cart_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFFFFFF),
      drawer: drawer(),
      body: SafeArea(
        child: Padding(
          padding: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxH15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 28.w,
                        color: Color(0xFF0F172A),
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.notifications_outlined,
                              size: 19.w,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        sizedBoxW10,
                        Obx(() {
                          final hasItems = homeController.totalCartItems > 0;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 40.w,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: hasItems
                                        ? Color(0xFF7C3AED)
                                        : Colors.grey.shade300,
                                    width: hasItems ? 2 : 1,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 19.w,
                                    color: hasItems
                                        ? Color(0xFF7C3AED)
                                        : Color(0xFF0F172A),
                                  ),
                                  onPressed: () {
                                    if (hasItems) {
                                      CartBottomSheet.show(context);
                                    }
                                  },
                                ),
                              ),
                              if (hasItems)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 14.w,
                                    width: 14.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7C3AED),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        homeController.totalCartItems > 99
                                            ? '99+'
                                            : '${homeController.totalCartItems}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                sizedBoxH15,
                CmTextField(
                  controller: homeController.searchController,
                  hintText: "Search",
                  prefixIcon: Icons.search,
                  suffixIcon: Icons.tune,
                ),
                sizedBoxH15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Subject Tutoring',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'All Subjects',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFF9F54F8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9F54F8),
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                sizedBoxH08,
                SubjectTutoringListView(),
                sizedBoxH08,
                const BannerWidget(),
                sizedBoxH08,
                Text(
                  'All Courses',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                sizedBoxH08,
                AllCoursesListView(),
                Text(
                  'Buy Materials',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                sizedBoxH08,
                MaterialsListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

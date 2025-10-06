import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_elevated_button.dart';
import 'package:flutter_application_1/view/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math';

class AuthSuccessfullScreen extends StatelessWidget {
  const AuthSuccessfullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          CustomPaint(painter: StaticConfettiPainter(), size: Size.infinite),
          SafeArea(
            child: Padding(
              padding: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  sizedBoxH50,
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF27AE60),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Color(0xFFFFFFFF),
                      size: 40.sp,
                    ),
                  ),

                  sizedBoxH35,
                  Text(
                    "Congrats!",
                    style: TextStyle(
                      fontFamily: "InterTight",
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  sizedBoxH10,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      "You have signed up successfully. Go to home & start exploring courses",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: const Color(0xFF475569),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        text: "Go to Home",
        onPressed: () {
          Get.to(() => HomeScreen());
        },
      ),
    );
  }
}

class StaticConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    final colors = [
      const Color(0xFFEF4444),
      const Color(0xFF3B82F6),
      const Color(0xFF22C55E),
      const Color(0xFFF59E0B),
      const Color(0xFFA855F7),
      const Color(0xFFEC4899),
      const Color(0xFF06B6D4),
    ];

    for (int i = 0; i < 60; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final confettiSize = 4 + random.nextDouble() * 6;
      final color = colors[random.nextInt(colors.length)];
      final rotation = random.nextDouble() * 2 * pi;

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: confettiSize,
            height: confettiSize * 0.6,
          ),
          const Radius.circular(1),
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(StaticConfettiPainter oldDelegate) => false;
}

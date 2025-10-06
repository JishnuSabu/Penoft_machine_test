import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget imagePickerWidget(AuthController controller) {
  return Obx(() {
    return GestureDetector(
      onTap: () => controller.pickAndUploadPicture(),
      child: controller.isUploading.value
          ? SizedBox(
              width: 100.w,
              height: 100.w,
              child: CircularProgressIndicator(color: Color(0xFF8932EB)),
            )
          : (controller.profilePictureUrl.value.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      controller.profilePictureUrl.value,
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : DashedCircleAvatar(
                    size: 100.w,
                    dashColor: const Color(0xFF8932EB),
                    strokeWidth: 2.w,
                    dashWidth: 6.w,
                    dashSpace: 6.w,
                    child: Icon(
                      Icons.camera_enhance_outlined,
                      size: 40.w,
                      color: const Color(0xFF8932EB),
                    ),
                  )),
    );
  });
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    this.color = const Color(0xFF8932EB),
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final circumference = 2 * pi * radius;

    final dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final dashAngle = (2 * pi) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = (dashWidth / circumference) * 2 * pi;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedCircleAvatar extends StatelessWidget {
  final double size;
  final Widget? child;
  final Color dashColor;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const DashedCircleAvatar({
    super.key,
    this.size = 100,
    this.child,
    this.dashColor = const Color(0xFF8932EB),
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size - strokeWidth * 2,
            height: size - strokeWidth * 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD4B4FE), Color(0xFF8932EB)],
                stops: [8, 80],
              ),
              shape: BoxShape.circle,
            ),
          ),
          if (child != null)
            SizedBox(
              width: size - strokeWidth * 4,
              height: size - strokeWidth * 4,
              child: child,
            ),
          CustomPaint(
            size: Size(size, size),
            painter: DashedCirclePainter(
              color: Color(0xFF8932EB),
              strokeWidth: strokeWidth,
              dashWidth: dashWidth,
              dashSpace: dashSpace,
            ),
          ),
        ],
      ),
    );
  }
}

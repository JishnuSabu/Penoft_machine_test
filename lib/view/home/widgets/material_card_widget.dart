import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homecontroller.dart';
import 'package:flutter_application_1/model/material_response_model.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MaterialCard extends StatelessWidget {
  final MaterialItem material;

  const MaterialCard({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Padding(
      padding: EdgeInsets.only(bottom: 12.w),
      child: SizedBox(
        width: 328.w,
        height: 126.w,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                material.image,
                width: 144.w,
                height: 124.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 144.w,
                    height: 124.w,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            sizedBoxW05,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    material.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "by ${material.brand}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF334155),
                        ),
                      ),
                      // Add/Cart Button
                      Obx(() {
                        final isInCart = controller.isInCart(material.title);
                        final quantity = controller.getQuantity(material.title);

                        if (isInCart) {
                          return _buildQuantityControl(
                            controller,
                            material.title,
                            quantity,
                          );
                        } else {
                          return _buildAddButton(controller, material.title);
                        }
                      }),
                    ],
                  ),
                  Divider(color: Color(0xFFE2E8F0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            material.price,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          sizedBoxW04,
                          Text(
                            material.originalPrice,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFFB923C),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${material.rating} (${material.reviews})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  customContainer(20.w, 74.w, material.tag),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(HomeController controller, String materialId) {
    return GestureDetector(
      onTap: () => controller.addToCart(materialId),
      child: Container(
        height: 20.w,
        width: 56.w,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E4FF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            "Add",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityControl(
    HomeController controller,
    String materialId,
    int quantity,
  ) {
    return Container(
      height: 22.w,
      width: 74.w,
      decoration: BoxDecoration(
        color: const Color(0xFF9F54F8),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => controller.decrementQuantity(materialId),
            child: SizedBox(
              height: 22.w,
              width: 20.w,
              child: Icon(Icons.remove, size: 15.sp, color: Color(0xFFFFFFFF)),
            ),
          ),
          Text(
            '$quantity',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
            ),
          ),
          GestureDetector(
            onTap: () => controller.incrementQuantity(materialId),
            child: SizedBox(
              height: 22.w,
              width: 20.w,
              child: Icon(Icons.add, size: 15.sp, color: Color(0xFFFFFFFF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget customContainer(double height, double width, String text) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E4FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
    );
  }
}

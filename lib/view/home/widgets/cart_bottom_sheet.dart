import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homecontroller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/widgets/cm_elevated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      height: 288.93.w,
      width: 375.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F1FF), Color(0xFFF6F0FF)],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: Color(0xFFD1C4E9),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          sizedBoxH18,
          Text(
            'Your cart details',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8932EB),
            ),
          ),
          sizedBoxH18,
          Obx(() {
            if (controller.cartItems.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 14.sp, color: Color(0xFF64748B)),
                ),
              );
            }

            return SizedBox(
              height: 50.w,
              child: ListView.builder(
                itemCount: controller.materials
                    .where((material) => controller.isInCart(material.title))
                    .length,
                itemBuilder: (context, index) {
                  final filteredMaterials = controller.materials
                      .where((material) => controller.isInCart(material.title))
                      .toList();
                  final material = filteredMaterials[index];
                  final quantity = controller.getQuantity(material.title);
                  return _buildCartItem(material, quantity);
                },
              ),
            );
          }),

          sizedBoxH18,
          Obx(() {
            final totalItems = controller.totalCartItems;
            final totalPrice = _calculateTotal(controller);

            return Container(
              height: 30.93.w,
              width: 327.w,
              decoration: BoxDecoration(
                color: Color(0xFF60B246),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$totalItems Item${totalItems > 1 ? 's' : ''} | ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
          sizedBoxH18,
          SizedBox(
            width: 327.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 44.w,
                  width: 157.w,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF9F54F8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9F54F8),
                      ),
                    ),
                  ),
                ),
                CustomElevatedButton(
                  text: "Checkout",
                  style: TextStyle(
                    fontSize: 16.1.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  height: 44.w,
                  width: 157.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(dynamic material, int quantity) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              material.image,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.grey[200],
                  child: Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          sizedBoxW10,
          SizedBox(
            width: 171.w,
            child: Text(
              material.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0F172A),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotal(HomeController controller) {
    double total = 0.0;
    for (var material in controller.materials) {
      if (controller.isInCart(material.title)) {
        final quantity = controller.getQuantity(material.title);
        final priceString = material.price
            .replaceAll('\$', '')
            .replaceAll(',', '');
        final price = double.tryParse(priceString) ?? 0.0;
        total += price * quantity;
      }
    }
    return total.toStringAsFixed(2);
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CartBottomSheet(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homecontroller.dart';
import 'package:flutter_application_1/model/material_response_model.dart';
import 'package:flutter_application_1/view/home/widgets/material_card_widget.dart';
import 'package:get/get.dart';

class MaterialsListView extends StatelessWidget {
  MaterialsListView({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isMaterialsLoading.value) {
        return Container(
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeController.materials.length,
        itemBuilder: (context, index) {
          final MaterialItem material = homeController.materials[index];
          return MaterialCard(material: material);
        },
      );
    });
  }
}

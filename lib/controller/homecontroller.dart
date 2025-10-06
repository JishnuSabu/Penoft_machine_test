import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/material_response_model.dart';
import 'package:flutter_application_1/model/subject_response_model.dart';
import 'package:flutter_application_1/model/course_response_model.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/api_service.dart';

class HomeController extends GetxController {
  var searchController = TextEditingController();

  // Subjects
  var subjects = <Subject>[].obs;
  var isSubjectLoading = false.obs;
  var errorMessage = ''.obs;

  // Banner
  var bannerUrl = ''.obs;
  var isBannerLoading = false.obs;
  var bannerErrorMessage = ''.obs;

  // Courses
  var courses = <Course>[].obs;
  var isCoursesLoading = false.obs;
  var coursesErrorMessage = ''.obs;

  // Materials
  var materials = <MaterialItem>[].obs;
  var isMaterialsLoading = false.obs;
  var materialsErrorMessage = ''.obs;

  // Cart - Map of material ID to quantity
  var cartItems = <String, int>{}.obs;

  late final ApiService apiService;

  @override
  void onInit() {
    super.onInit();
    apiService = ApiService(baseUrl: baseUrl);
    fetchBanner();
    fetchSubjects();
    fetchCourses();
    fetchMaterials();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  void addToCart(String materialId) {
    cartItems[materialId] = 1;
  }

  void incrementQuantity(String materialId) {
    if (cartItems.containsKey(materialId)) {
      cartItems[materialId] = cartItems[materialId]! + 1;
    }
  }

  void decrementQuantity(String materialId) {
    if (cartItems.containsKey(materialId)) {
      if (cartItems[materialId]! > 1) {
        cartItems[materialId] = cartItems[materialId]! - 1;
      } else {
        removeFromCart(materialId);
      }
    }
  }

  void removeFromCart(String materialId) {
    cartItems.remove(materialId);
  }

  int getQuantity(String materialId) {
    return cartItems[materialId] ?? 0;
  }

  bool isInCart(String materialId) {
    return cartItems.containsKey(materialId);
  }

  int get totalCartItems {
    return cartItems.values.fold(0, (sum, quantity) => sum + quantity);
  }

  Future<void> fetchBanner() async {
    try {
      isBannerLoading.value = true;
      bannerErrorMessage.value = '';
      final response = await apiService.getBanner();
      bannerUrl.value = response.data;
    } catch (e) {
      bannerErrorMessage.value = e.toString();
    } finally {
      isBannerLoading.value = false;
    }
  }

  Future<void> fetchSubjects() async {
    try {
      isSubjectLoading.value = true;
      errorMessage.value = '';
      final response = await apiService.getSubjects();
      subjects.value = response.data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isSubjectLoading.value = false;
    }
  }

  Future<void> fetchCourses() async {
    try {
      isCoursesLoading.value = true;
      coursesErrorMessage.value = '';
      final response = await apiService.getCourses();
      courses.value = response.data;
    } catch (e) {
      coursesErrorMessage.value = e.toString();
    } finally {
      isCoursesLoading.value = false;
    }
  }

  Future<void> fetchMaterials() async {
    try {
      isMaterialsLoading.value = true;
      materialsErrorMessage.value = '';
      final response = await apiService.getMaterials();
      materials.value = response.data;
    } catch (e) {
      materialsErrorMessage.value = e.toString();
    } finally {
      isMaterialsLoading.value = false;
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([
      fetchBanner(),
      fetchSubjects(),
      fetchCourses(),
      fetchMaterials(),
    ]);
  }

  Future<void> refreshSubjects() async {
    await refreshAll();
  }
}

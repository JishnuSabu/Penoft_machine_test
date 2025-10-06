import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/view/auth/add_name_screen.dart';
import 'package:flutter_application_1/view/auth/auth_successfull_screen.dart';
import 'package:flutter_application_1/view/auth/profile_screen.dart';
import 'package:flutter_application_1/view/auth/signup_screen.dart';
import 'package:flutter_application_1/view/auth/widgets/snack_bar_widget.dart';
import 'package:flutter_application_1/view/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../view/auth/verfication_code_screen.dart';

class AuthController extends GetxController {
  var signupEmailController = TextEditingController();
  var addFullNameController = TextEditingController();
  var fetchedNameController = TextEditingController();
  var fetchedMailIdController = TextEditingController();
  var fetchedPhNoController = TextEditingController();
  var otpController = TextEditingController();

  var isLoading = false.obs;
  var resendTimer = 39.obs;
  var canResend = false.obs;
  var verificationType = "signup".obs;
  var signupEmail = ''.obs;
  var fullName = ''.obs;
  var jwtToken = ''.obs;
  var isAddNameLoading = false.obs;

  var profilePictureUrl = ''.obs;
  var isUploading = false.obs;
  var fetchedName = ''.obs;

  Timer? _timer;

  late final ApiService apiService;

  @override
  void onInit() {
    super.onInit();
    apiService = ApiService(baseUrl: baseUrl);
    checkToken();
    startResendTimer();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
  }

  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        Get.off(() => MainScreen());
      } else {
        Get.off(() => SignupScreen());
      }
    });
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    jwtToken.value = '';
    apiService.token = null;
    Get.offAll(SignupScreen());
  }

  Future<void> loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('signupEmail') ?? '';
    if (savedEmail.isNotEmpty) {
      signupEmail.value = savedEmail;
      fetchedMailIdController.text = savedEmail;
    }
  }

  void startResendTimer() {
    resendTimer.value = 39;
    canResend.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

  Future<void> requestOtp() async {
    try {
      isLoading.value = true;
      final email = signupEmailController.text.trim();
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('signupEmail', email);

      signupEmail.value = email;
      final data = await apiService.sendOtp(signupEmail.value);
      snackBarWidget(
        status: 'Success',
        msg: data['message'] ?? 'OTP sent successfully',
        color: Colors.green,
      );

      verificationType.value = data['type'] ?? 'signup';
      Get.to(() => VerificationCodeScreen());
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: e.toString().replaceAll('Exception: ', ''),
        color: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      isLoading.value = true;

      final data = await apiService.verifyOtp(
        signupEmailController.text.trim(),
        otp,
      );

      jwtToken.value = data['token'];
      apiService.token = jwtToken.value;
      await saveToken(jwtToken.value);
      snackBarWidget(
        status: 'Success',
        msg: data['message'] ?? 'OTP verified successfully',
        color: Colors.green,
      );

      Get.to(() => AddNameScreen());
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: e.toString().replaceAll('Exception: ', ''),
        color: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;

    try {
      isLoading.value = true;

      final data = await apiService.sendOtp(signupEmailController.text.trim());

      startResendTimer();
      snackBarWidget(
        status: 'Success',
        msg: data['message'] ?? 'Verification code sent successfully',
        color: Colors.green,
      );
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: e.toString().replaceAll('Exception: ', ''),
        color: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addFullName({bool navigate = true}) async {
    try {
      final name = addFullNameController.text.trim();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      fullName.value = name;
      isAddNameLoading.value = true;
      await apiService.addFullName(name);
      await getUserDetails();
      if (navigate) {
        Get.to(() => ProfileScreen(), arguments: {'fromGoogle': false});
      }
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: e.toString().replaceAll('Exception: ', ''),
        color: Colors.red,
      );
    } finally {
      isAddNameLoading.value = false;
    }
  }

  Future<void> getUserDetails() async {
    try {
      final userData = await apiService.getUser();
      final user = userData['user'];

      fetchedNameController.text = user['fullname'] ?? '';
      fetchedMailIdController.text = user['email'] ?? '';
      profilePictureUrl.value = user['picture'] ?? '';
      snackBarWidget(
        status: 'Success',
        msg: userData['message'] ?? 'Profile fetched successfully',
        color: Colors.green,
      );
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: e.toString().replaceAll('Exception: ', ''),
        color: Colors.red,
      );
    } finally {}
  }

  Future<void> pickAndUploadPicture() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        isUploading.value = true;
        final response = await apiService.uploadProfilePicture(pickedFile.path);
        profilePictureUrl.value = response['picture'];
        snackBarWidget(
          status: 'Success',
          msg: response['message'] ?? 'Profile Picture updated successfully',
          color: Colors.green,
        );
      }
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: e.toString().replaceAll('Exception: ', ''),
        color: Colors.red,
      );
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> createUser() async {
    try {
      if (fetchedNameController.text.trim().isEmpty ||
          fetchedMailIdController.text.trim().isEmpty) {
        snackBarWidget(
          status: 'Error',
          msg: 'Please fill all details and upload a profile picture',
          color: Colors.red,
        );
        return;
      }
      isLoading.value = true;
      final response = await apiService.createUser(
        fullname: fetchedNameController.text.trim(),
        email: fetchedMailIdController.text.trim(),
        phone: fetchedPhNoController.text.trim(),
        picture: profilePictureUrl.value,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', "google_${response['email']}");
      snackBarWidget(
        status: 'Success',
        msg: response['message'] ?? 'User created successfully',
        color: Colors.green,
      );
      Get.offAll(() => AuthSuccessfullScreen());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    signupEmailController.dispose();
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        fetchedNameController.text = account.displayName ?? '';
        fetchedMailIdController.text = account.email;
        profilePictureUrl.value = account.photoUrl ?? '';

        Get.to(() => ProfileScreen(), arguments: {'fromGoogle': true});
      }
    } catch (e) {
      snackBarWidget(
        status: 'Error',
        msg: 'Failed to sign in with Google',
        color: Colors.red,
      );
    }
  }
}

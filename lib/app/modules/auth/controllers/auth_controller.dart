import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import '../../../errors/failure.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  // Login form controllers
  late TextEditingController emailLoginController;
  late TextEditingController passwordLoginController;

  // Register form controllers
  late TextEditingController usernameController;
  late TextEditingController emailRegisterController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController passwordRegisterController;
  late TextEditingController confirmPasswordController;

  // Forgot password controller
  late TextEditingController emailForgotController;

  // OTP Verification Form
  final otpFormKey = GlobalKey<FormState>();
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;
  final remainingSeconds = 60.obs;
  Timer? _resendTimer;

  // Reset Password Form
  final resetPasswordFormKey = GlobalKey<FormState>();
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  // Observable variables
  final email = ''.obs;
  final password = ''.obs;
  final phoneNumber = ''.obs;
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final acceptTerms = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Computed getters
  bool get canResendOtp => remainingSeconds.value == 0;

  String get formattedTime {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get getOtpString =>
      otpControllers.map((controller) => controller.text).join();

  @override
  void onInit() {
    super.onInit();
    _initControllers();
  }

  void _initControllers() {
    // Initialize all controllers
    emailLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
    usernameController = TextEditingController();
    emailRegisterController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();
    passwordRegisterController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailForgotController = TextEditingController();
    otpControllers = List.generate(5, (_) => TextEditingController());
    otpFocusNodes = List.generate(5, (_) => FocusNode());
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();

    // Setup controller listeners to update observable values
    emailLoginController
        .addListener(() => email.value = emailLoginController.text);
    passwordLoginController
        .addListener(() => password.value = passwordLoginController.text);
    phoneController.addListener(() => phoneNumber.value = phoneController.text);
  }

  @override
  void onClose() {
    // Dispose all controllers
    _disposeControllers();
    _resendTimer?.cancel();
    super.onClose();
  }

  void _disposeControllers() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    usernameController.dispose();
    emailRegisterController.dispose();
    phoneController.dispose();
    cityController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordController.dispose();
    emailForgotController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }

  // Reset controllers for reuse
  void reset() {
    acceptTerms.value = false;
    _disposeControllers();
    _initControllers();
  }

  // Called when switching between login and register screens
  void resetLoginForm() {
    emailLoginController.clear();
    passwordLoginController.clear();
    acceptTerms.value = false;
  }

  // Login function
  Future<void> login() async {
    if (loginFormKey.currentState?.validate() != true) {
      return;
    }

    if (!acceptTerms.value) {
      showMessage('يرجى الموافقة على الشروط والأحكام', isError: true);
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Set logged in status
      isLoggedIn.value = true;
      showMessage('تم تسجيل الدخول بنجاح');

      // Navigation happens in the view
    } catch (e) {
      if (e is AuthFailure) {
        showMessage(e.message, isError: true);
      } else if (e is NetworkFailure) {
        showMessage(e.message, isError: true);
      } else if (e is ServerFailure) {
        showMessage(e.message, isError: true);
      } else {
        showMessage('فشل تسجيل الدخول', isError: true);
      }
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Google sign in
  Future<void> signInWithGoogle() async {
    if (!acceptTerms.value) {
      showMessage('يرجى الموافقة على الشروط والأحكام', isError: true);
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Set logged in status
      isLoggedIn.value = true;
      showMessage('تم تسجيل الدخول بنجاح عبر حساب جوجل');

      // Navigate to home
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      if (e is AuthFailure) {
        showMessage(e.message, isError: true);
      } else if (e is NetworkFailure) {
        showMessage(e.message, isError: true);
      } else {
        showMessage('فشل تسجيل الدخول عبر حساب جوجل', isError: true);
      }
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Register function
  Future<void> register() async {
    if (registerFormKey.currentState?.validate() != true) {
      return;
    }

    if (!acceptTerms.value) {
      showMessage('يرجى الموافقة على الشروط والأحكام', isError: true);
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      showMessage('تم إنشاء الحساب بنجاح');

      // Save email for registration success screen
      final email = emailRegisterController.text.trim();

      // Reset controllers before navigation
      reset();

      // Navigate to registration success screen
      Get.offAllNamed(Routes.REGISTER_SUCCESS, arguments: {
        'email': email,
      });
    } catch (e) {
      if (e is AuthFailure) {
        showMessage(e.message, isError: true);
      } else if (e is NetworkFailure) {
        showMessage(e.message, isError: true);
      } else {
        showMessage('فشل إنشاء الحساب', isError: true);
      }
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot password
  Future<void> forgotPassword() async {
    if (forgotPasswordFormKey.currentState?.validate() != true) {
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      showMessage('تم إرسال رابط إعادة تعيين كلمة المرور');

      // Navigate back
      Get.back();
    } catch (e) {
      if (e is AuthFailure) {
        showMessage(e.message, isError: true);
      } else if (e is NetworkFailure) {
        showMessage(e.message, isError: true);
      } else {
        showMessage('فشل إرسال رابط إعادة التعيين', isError: true);
      }
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Logout function
  void logout() {
    isLoggedIn.value = false;
    reset();
    Get.offAllNamed(Routes.LOGIN);
  }

  // Method to pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      showMessage('فشل في اختيار الصورة: $e', isError: true);
    }
  }

  // Method to pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      showMessage('فشل في التقاط الصورة: $e', isError: true);
    }
  }

  // Show image selection dialog
  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'اختر مصدر الصورة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('معرض الصور'),
                onTap: () {
                  Get.back();
                  pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('الكاميرا'),
                onTap: () {
                  Get.back();
                  pickImageFromCamera();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Update terms acceptance
  void setTermsAcceptance(bool value) {
    acceptTerms.value = value;
  }

  // Show message
  void showMessage(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'خطأ' : 'تم',
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      // Implement actual OTP verification logic here
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> resendOtp(String email) async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      // Implement actual resend OTP logic here
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      // Implement actual reset password logic here

      // Reset controller state
      reset();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  void startResendTimer() {
    _resendTimer?.cancel();
    remainingSeconds.value = 60;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _resendTimer?.cancel();
      }
    });
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/data/services/dio_client.dart';
import '../../../../core/data/services/shared_preferences.dart';
import '../../../../routes/app_routes.dart';
import '../../../shared/onboarding/data/models/user_role.dart';
import '../../data/models/user/user_model.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  late TextEditingController emailLoginController, passwordLoginController;
  late TextEditingController usernameController, emailRegisterController, passwordRegisterController, confirmPasswordController;
  late TextEditingController phoneController, cityController, specializationController;
  late TextEditingController emailForgotController;
  late TextEditingController newPasswordController, confirmNewPasswordController;

  late TextEditingController consultationFeeController;
  late TextEditingController judgeSpecializationController;
  late TextEditingController courtNameController;

  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;
  final remainingSeconds = 60.obs;
  Timer? _resendTimer;

  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final acceptTerms = false.obs;
  final selectedImage = Rx<File?>(null);
  final userRole = Rxn<UserRole>();
  String? email;

  final currentUser = Rxn<UserModel>();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _initControllers();
    _loadUserFromStorage();
  }

  void _initControllers() {
    emailLoginController = TextEditingController();
    passwordLoginController = TextEditingController();

    usernameController = TextEditingController();
    emailRegisterController = TextEditingController();
    passwordRegisterController = TextEditingController();
    confirmPasswordController = TextEditingController();

    phoneController = TextEditingController();
    cityController = TextEditingController();
    specializationController = TextEditingController();

    emailForgotController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();

    consultationFeeController = TextEditingController();
    judgeSpecializationController = TextEditingController();
    courtNameController = TextEditingController();

    otpControllers = List.generate(6, (_) => TextEditingController());
    otpFocusNodes = List.generate(6, (_) => FocusNode());
  }

  void _loadUserFromStorage() async {
    final user = await SharedPrefHelper.getUser();
    final token = await SharedPrefHelper.getToken();
    if (user != null && token != null) {
      DioClient().updateToken(token);
      currentUser.value = user;
      isLoggedIn.value = true;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _disposeControllers();
    _resendTimer?.cancel();
  }

  void _disposeControllers() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    usernameController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    cityController.dispose();
    specializationController.dispose();
    emailForgotController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    consultationFeeController.dispose();
    judgeSpecializationController.dispose();
    courtNameController.dispose();
    otpControllers.forEach((c) => c.dispose());
    otpFocusNodes.forEach((f) => f.dispose());
  }

  void setTermsAcceptance(bool value) {
    acceptTerms.value = value;
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate() || !acceptTerms.value) return;
    isLoading.value = true;
    try {
      final token = await DioClient().loginUser(emailLoginController.text, passwordLoginController.text);
      DioClient().updateToken(token);
      await SharedPrefHelper.saveToken(token);

      // TODO: Fetch user model from API
      // UserModel user = ...;
      // currentUser.value = user;
      // await SharedPrefHelper.saveUser(user);

      isLoggedIn.value = true;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('خطأ', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    if (!acceptTerms.value) {
      Get.snackbar('تنبيه', 'يرجى الموافقة على الشروط والأحكام', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final email = googleUser.email;
      final name = googleUser.displayName ?? 'مستخدم Google';

      final token = await DioClient().loginWithGoogle(email: email, name: name);
      DioClient().updateToken(token);
      await SharedPrefHelper.saveToken(token);

      // TODO: Fetch user model from API
      // UserModel user = ...;
      // currentUser.value = user;
      // await SharedPrefHelper.saveUser(user);

      isLoggedIn.value = true;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تسجيل الدخول عبر Google: $e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate() || !acceptTerms.value) return;
    isLoading.value = true;
    try {
      await DioClient().registerUser(
        name: usernameController.text,
        email: emailRegisterController.text,
        password: passwordRegisterController.text,
        phone: phoneController.text,
        city: cityController.text,
        specialization: specializationController.text,
        role: userRole.value?.name ?? 'client',
        profileImagePath: selectedImage.value?.path ?? '',
      );
      Get.offAllNamed(Routes.REGISTER_SUCCESS, arguments: {'email': emailRegisterController.text});
    } catch (e) {
      Get.snackbar('خطأ', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (!forgotPasswordFormKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await DioClient().requestPasswordReset(emailForgotController.text);
      Get.snackbar('تم', 'تم إرسال رابط إعادة التعيين', backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('خطأ', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    try {
      await DioClient().verifyOtp(email, otp);
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('خطأ', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    if (!resetPasswordFormKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await DioClient().resetPassword(email, newPassword);
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('خطأ', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtpToEmail(String email) async {
    isLoading.value = true;
    try {
      await DioClient().sendOtpToEmail(email);
      startOtpTimer();
      Get.snackbar('تم', 'تم إرسال رمز التحقق إلى بريدك الإلكتروني', backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('خطأ', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void startOtpTimer() {
    remainingSeconds.value = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void showMessage(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'خطأ' : 'نجاح',
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }

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

  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'اختر مصدر الصورة',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold),
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
}

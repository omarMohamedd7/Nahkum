import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_app/app/features/auth/presentation/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final isLoading = false.obs;

  late final AuthController _authController;

  String get name => _authController.currentUser.value?.name ?? 'غير معروف';
  String get email => _authController.currentUser.value?.email ?? 'غير معروف';
  String? get imageUrl => _authController.currentUser.value?.profilePic;

  @override
  void onInit() {
    super.onInit();
    _authController = Get.find<AuthController>();
  }

  void updateUserProfile({String? name, String? email, String? imageUrl}) {
    // سيتم لاحقًا ربط هذا بالباك اند إذا لزم الأمر
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
        await updateProfileImage(pickedFile.path);
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
        await updateProfileImage(pickedFile.path);
      }
    } catch (e) {
      showMessage('فشل في التقاط الصورة: $e', isError: true);
    }
  }

  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('اختر مصدر الصورة', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold)),
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

  Future<void> updateProfileImage(String imagePath) async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      showMessage('تم تحديث صورة الملف الشخصي بنجاح');
    } catch (e) {
      showMessage('فشل في تحديث صورة الملف الشخصي', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveUserProfile() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      showMessage('تم تحديث الملف الشخصي بنجاح');
      return true;
    } catch (e) {
      showMessage('فشل في حفظ الملف الشخصي', isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void showMessage(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'خطأ' : 'تم',
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

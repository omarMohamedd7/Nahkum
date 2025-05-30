import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile {
  final String name;
  final String email;
  final String? imageUrl;

  UserProfile({
    required this.name,
    required this.email,
    this.imageUrl,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? imageUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class ProfileController extends GetxController {
  // Image picker instance
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final isLoading = false.obs;

  // Observable variables with .obs suffix
  final _userProfile = UserProfile(
    name: 'أسم المستخدم',
    email: 'username1234@gmail.com',
    imageUrl: null,
  ).obs;

  // Getters to access the reactive state
  UserProfile get userProfile => _userProfile.value;
  String get name => _userProfile.value.name;
  String get email => _userProfile.value.email;
  String? get imageUrl => _userProfile.value.imageUrl;

  // Update user profile function
  void updateUserProfile({String? name, String? email, String? imageUrl}) {
    _userProfile.update((profile) {
      profile = profile!.copyWith(
        name: name,
        email: email,
        imageUrl: imageUrl,
      );
    });
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
        await updateProfileImage(pickedFile.path);
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
        await updateProfileImage(pickedFile.path);
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

  // This method would typically handle uploading the image to a server
  // and updating the user profile with the new image URL
  Future<void> updateProfileImage(String imagePath) async {
    isLoading.value = true;

    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 1));

      // Update the profile with the new image
      updateUserProfile(imageUrl: imagePath);
      showMessage('تم تحديث صورة الملف الشخصي بنجاح');
    } catch (e) {
      showMessage('فشل في تحديث صورة الملف الشخصي', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // This method would typically make an API call to update the user's profile
  // on the server
  Future<bool> saveUserProfile() async {
    isLoading.value = true;

    try {
      // Simulate a network request
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
}

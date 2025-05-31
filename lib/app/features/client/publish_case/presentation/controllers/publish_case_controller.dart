import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../errors/failure.dart';
import '../../data/models/publish_case_model.dart';

enum FileType { image, document, audio }

class PublishCaseController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final caseDescriptionController = TextEditingController();

  // Reactive variables
  final RxString caseType = ''.obs;
  final RxString targetCity = ''.obs;
  final RxList<File> selectedFiles = <File>[].obs;
  final RxBool isSubmitting = false.obs;

  // Case types dropdown options
  final List<String> caseTypes = [
    'جنائي',
    'مدني',
    'تجاري',
    'أحوال شخصية',
    'إداري',
    'عمالي',
  ];

  // City dropdown options
  final List<String> cities = [
    'دمشق',
    'حلب',
    'حماه',
    'اللاذقية',
    'دير الزور',
  ];

  @override
  void onClose() {
    caseDescriptionController.dispose();
    super.onClose();
  }

  void setCaseType(String? value) {
    caseType.value = value ?? '';
  }

  void setTargetCity(String? value) {
    targetCity.value = value ?? '';
  }

  Future<void> handleFilePickerSelect(FileType fileType) async {
    switch (fileType) {
      case FileType.image:
        await pickFiles();
        break;
      case FileType.document:
        await pickDocuments();
        break;
      case FileType.audio:
        showAudioNotSupportedMessage();
        break;
    }
  }

  Future<void> pickFiles() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        selectedFiles.add(File(pickedFile.path));
      }
    } catch (e) {
      final failure = FileFailure.uploadFailed();
      showErrorMessage(failure.message);
    }
  }

  Future<void> pickDocuments() async {
    // In a real app, you would implement document picking functionality
    // This is a placeholder to demonstrate the UI
    selectedFiles.add(File('document.pdf'));
  }

  void showAudioNotSupportedMessage() {
    Get.snackbar(
      'غير مدعوم',
      'سيتم دعم الملفات الصوتية قريباً',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'خطأ',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
  }

  void submitForm() {
    if (formKey.currentState?.validate() == true) {
      isSubmitting.value = true;

      // Create the publish case model
      final publishCase = PublishCaseModel(
        caseType: caseType.value,
        description: caseDescriptionController.text,
        attachments: selectedFiles,
        targetCity: targetCity.value.isNotEmpty ? targetCity.value : null,
      );

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        isSubmitting.value = false;

        // Here you would send the publishCase to your API

        Get.snackbar(
          'تم',
          'تم نشر القضية بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.back();
      });
    }
  }

  void goBack() {
    Get.back();
  }
}

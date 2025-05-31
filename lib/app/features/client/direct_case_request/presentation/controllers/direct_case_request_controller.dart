import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../errors/failure.dart';
import 'package:legal_app/app/features/client/direct_case_request/data/models/case_request_model.dart';
import 'package:legal_app/app/routes/app_routes.dart';

enum FileType { image, document, audio }

class DirectCaseRequestController extends GetxController {
  // Form controllers
  final formKey = GlobalKey<FormState>();
  final plaintiffNameController = TextEditingController();
  final defendantNameController = TextEditingController();
  final caseNumberController = TextEditingController();
  final caseDescriptionController = TextEditingController();

  // Reactive variables
  final RxString caseType = ''.obs;
  final RxList<File> selectedFiles = <File>[].obs;
  final RxBool isSubmitting = false.obs;

  @override
  void onClose() {
    plaintiffNameController.dispose();
    defendantNameController.dispose();
    caseNumberController.dispose();
    caseDescriptionController.dispose();
    super.onClose();
  }

  void setCaseType(String? type) {
    caseType.value = type ?? '';
  }

  void goBack() {
    Get.back();
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

      // Simulate form submission
      Future.delayed(const Duration(seconds: 1), () {
        isSubmitting.value = false;

        final caseRequest = CaseRequestModel(
          caseType: caseType.value,
          plaintiffName: plaintiffNameController.text,
          defendantName: defendantNameController.text,
          caseNumber: caseNumberController.text,
          caseDescription: caseDescriptionController.text,
          attachment: selectedFiles,
          createdAt: DateTime.now(),
        );

        // Here you would send the caseRequest to your API

        Get.snackbar(
          'تم',
          'تم ارسال طلبك الى المحامي بانتظار الموافقة',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed(Routes.HOME);
      });
    }
  }
}

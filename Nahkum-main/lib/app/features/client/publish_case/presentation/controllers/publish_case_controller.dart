import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../errors/failure.dart';
import '../../data/models/publish_case_model.dart';

enum FileType { image, document, audio }

class PublishCaseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final caseDescriptionController = TextEditingController();

  final RxString caseType = ''.obs;
  final RxString targetCity = ''.obs;
  final RxList<File> selectedFiles = <File>[].obs;
  final RxBool isSubmitting = false.obs;

  final List<String> caseTypes = [
    'جنائي',
    'مدني',
    'تجاري',
    'أحوال شخصية',
    'إداري',
    'عمالي',
  ];

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

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() == true) {
      isSubmitting.value = true;

      try {
        final dioClient = dio.Dio();
        final url = 'http://192.168.1.108:8000/api/published-cases';

        final formData = dio.FormData.fromMap({
          "case_number": "PC-2024-001",
          "plaintiff_name": "أحمد محمد",
          "defendant_name": "شركة الإعمار",
          "case_type": caseType.value,
          "description": caseDescriptionController.text,
          "target_city": targetCity.value,
          "target_specialization": caseType.value,
          "attachments": [
            for (var file in selectedFiles)
              await dio.MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              ),
          ],
        });

        final response = await dioClient.post(url, data: formData);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar(
            'تم',
            'تم نشر القضية بنجاح',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.back();
        } else {
          showErrorMessage('فشل في إرسال البيانات. رمز الحالة: ${response.statusCode}');
        }
      } catch (e) {
        showErrorMessage('حدث خطأ أثناء الإرسال: $e');
      } finally {
        isSubmitting.value = false;
      }
    }
  }

  void goBack() {
    Get.back();
  }
}

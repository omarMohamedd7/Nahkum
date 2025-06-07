import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitOfferController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final messageController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    priceController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> submitOffer(String caseType, String city) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final price = priceController.text;
    final message = messageController.text;

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // In a real app, you would send the data to your API
      // final response = await apiService.submitOffer(price, message, caseType, city);

      // Show success message
      Get.snackbar(
        'تم إرسال العرض بنجاح',
        'سيتم إشعارك عند الرد على عرضك',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 3),
      );

      // Navigate back
      Get.back();
    } catch (e) {
      // Show error message
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إرسال العرض، الرجاء المحاولة مرة أخرى',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(8),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

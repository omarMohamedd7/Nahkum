import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/lawyer_model.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../core/data/models/lawyer.dart';

class ConsultationController extends GetxController {
  // Form controllers
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final ccvController = TextEditingController();

  // Reactive variables
  final RxBool isLoading = false.obs;
  final Rx<LawyerModel?> selectedLawyer = Rx<LawyerModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // If lawyer was passed through arguments
    if (Get.arguments != null) {
      if (Get.arguments is Lawyer) {
        // Convert core Lawyer to LawyerModel
        final coreLawyer = Get.arguments as Lawyer;
        selectedLawyer.value = LawyerModel(
          id: coreLawyer.id,
          name: coreLawyer.name,
          location: coreLawyer.location,
          description: coreLawyer.description,
          price: coreLawyer.price,
          imageUrl: coreLawyer.imageUrl,
          specialization: coreLawyer.specialization,
        );
      } else if (Get.arguments is LawyerModel) {
        selectedLawyer.value = Get.arguments;
      } else if (Get.arguments is Map) {
        // Handle case where lawyer is passed as a map (for backward compatibility)
        final map = Get.arguments as Map;
        if (map.containsKey('lawyer')) {
          final lawyer = map['lawyer'];
          if (lawyer is Lawyer) {
            // Convert core Lawyer to LawyerModel
            selectedLawyer.value = LawyerModel(
              id: lawyer.id,
              name: lawyer.name,
              location: lawyer.location,
              description: lawyer.description,
              price: lawyer.price,
              imageUrl: lawyer.imageUrl,
              specialization: lawyer.specialization,
            );
          }
        }
      }
    }

    // If no lawyer was set, use a default
    if (selectedLawyer.value == null) {
      selectedLawyer.value = LawyerModel(
        id: '1',
        name: 'أسم المحامي',
        location: 'دمشق',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد',
        price: 20.5,
        imageUrl: 'assets/images/person.svg',
        specialization: 'قانون مدني',
      );
    }
  }

  @override
  void onClose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    ccvController.dispose();
    super.onClose();
  }

  void goBack() {
    Get.back();
  }

  void submitRequest() {
    // Validate form fields
    if (!validateForm()) {
      Get.snackbar(
        'خطأ في البيانات',
        'الرجاء ملء جميع الحقول المطلوبة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Show loading
    isLoading.value = true;

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 1000), () {
      isLoading.value = false;

      // Navigate to home after successful payment
      Get.offAllNamed(Routes.HOME);

      // Show success message
      Get.snackbar(
        'تم الطلب بنجاح',
        'تم إرسال طلب الاستشارة بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  bool validateForm() {
    return cardNameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        expiryDateController.text.isNotEmpty &&
        ccvController.text.isNotEmpty;
  }
}

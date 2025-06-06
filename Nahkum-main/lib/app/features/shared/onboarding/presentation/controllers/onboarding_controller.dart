import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/models/user_role.dart';
import '../../../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  // Reactive variables
  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);

  // Method to select a role
  void selectRole(UserRole role) {
    selectedRole.value = role;
    print('Role selected: ${role.toString()}');
  }

  // Method to navigate to login
  void navigateToLogin() {
    if (selectedRole.value != null) {
      print('Navigating to login with role: ${selectedRole.value.toString()}');
      Get.toNamed(Routes.LOGIN, arguments: {'role': selectedRole.value});
    } else {
      print('No role selected, cannot navigate to login');
      // Show a snackbar or alert to inform the user to select a role
      Get.snackbar(
        'تنبيه',
        'يرجى اختيار نوع الحساب',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to navigate directly to register screen (for testing)
  void navigateToRegister(UserRole role) {
    print('Navigating directly to register with role: ${role.toString()}');
    Get.toNamed(Routes.REGISTER, arguments: {'role': role});
  }

  // Helper method to check if screen is small
  bool isScreenSmall(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return screen.width < 360 || screen.height < 640;
  }
}

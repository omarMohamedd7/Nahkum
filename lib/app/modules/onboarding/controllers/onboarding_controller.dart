import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user_role.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  // Reactive variables
  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);

  // Method to select a role
  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  // Method to navigate to login
  void navigateToLogin() {
    if (selectedRole.value != null) {
      Get.toNamed(Routes.LOGIN);
    }
  }

  // Helper method to check if screen is small
  bool isScreenSmall(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return screen.width < 360 || screen.height < 640;
  }
}

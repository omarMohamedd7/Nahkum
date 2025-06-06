import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/routes/app_routes.dart';

class SettingsController extends GetxController {
  // Observable variables
  final RxString userName = 'أسم المستخدم'.obs;
  final RxString userEmail = 'user@example.com'.obs;
  final RxBool notificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    // Mock data - in a real app, fetch from user service
    userName.value = 'أحمد محمد';
    userEmail.value = 'ahmed@example.com';
  }

  void navigateToProfile() {
    Get.toNamed(Routes.PROFILE);
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;

    // In a real app, save this preference to user settings
    Get.snackbar(
      'الإشعارات',
      notificationsEnabled.value ? 'تم تفعيل الإشعارات' : 'تم إيقاف الإشعارات',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToPrivacyPolicy() {
    // Navigate to privacy policy page
    Get.snackbar(
      'سياسة الخصوصية',
      'سيتم فتح صفحة سياسة الخصوصية',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToAboutApp() {
    // Navigate to about app page
    Get.snackbar(
      'حول التطبيق',
      'سيتم فتح صفحة حول التطبيق',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'تسجيل الخروج',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Almarai',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'Almarai',
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: logout,
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(
                fontFamily: 'Almarai',
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    // Clear user session, token, etc.
    Get.offAllNamed(Routes.LOGIN);
  }
}

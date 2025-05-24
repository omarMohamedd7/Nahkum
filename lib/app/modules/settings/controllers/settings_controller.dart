import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SettingsController extends GetxController {
  // Observable variables
  final RxBool notificationsEnabled = true.obs;
  final RxString userName = 'أسم المستخدم'.obs;
  final RxString userEmail = 'username1234@gmail.com'.obs;

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
    // Here you would typically call an API or save the setting to local storage
  }

  void navigateToProfile() {
    Get.toNamed(Routes.PROFILE);
  }

  void navigateToPrivacyPolicy() {
    // Implement navigation to privacy policy
    // Get.toNamed(Routes.PRIVACY_POLICY);
  }

  void navigateToAboutApp() {
    // Implement navigation to about app
    // Get.toNamed(Routes.ABOUT);
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
          'هل أنت متأكد من تسجيل الخروج؟',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Almarai',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'Almarai',
                color: Colors.grey,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text(
              'تأكيد',
              style: TextStyle(
                fontFamily: 'Almarai',
                color: Color(0xFFC8A45D),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Get.back();
              logout();
            },
          ),
        ],
      ),
    );
  }

  void logout() {
    // Here you would typically clear user session data
    Get.offAllNamed(Routes.LOGIN);
  }
}

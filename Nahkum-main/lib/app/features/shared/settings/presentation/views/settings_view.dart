import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/features/shared/settings/presentation/controllers/settings_controller.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:legal_app/app/features/shared/settings/presentation/widgets/custom_toggle_switch.dart';
import 'package:legal_app/app/features/shared/settings/presentation/widgets/settings_item.dart';
import 'package:legal_app/app/features/shared/settings/presentation/widgets/user_profile_card.dart';

import '../../../../../core/theme/app_colors.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(top: 21.0, bottom: 32.0),
                child: Text(
                  'الإعدادات',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Profile section
              Obx(() => UserProfileCard(
                    userName: controller.userName.value,
                    userEmail: controller.userEmail.value,
                    onTap: controller.navigateToProfile,
                  )),

              // Settings items
              Expanded(
                child: ListView(
                  children: [
                    // Notifications setting
                    Obx(() => SettingsItem(
                          title: 'الإشعارات',
                          iconPath: 'assets/images/notification.svg',
                          onTap: controller.toggleNotifications,
                          trailing: CustomToggleSwitch(
                            value: controller.notificationsEnabled.value,
                            onChanged: (value) =>
                                controller.toggleNotifications(),
                          ),
                        )),

                    // Privacy policy
                    SettingsItem(
                      title: 'سياسة الخصوصية',
                      iconPath: 'assets/images/security.svg',
                      onTap: controller.navigateToPrivacyPolicy,
                    ),

                    // About the app
                    SettingsItem(
                      title: 'حول التطبيق',
                      iconPath: 'assets/images/info-circle.svg',
                      onTap: controller.navigateToAboutApp,
                    ),

                    // Logout
                    SettingsItem(
                      title: 'تسجيل الخروج',
                      iconPath: 'assets/images/logout.svg',
                      onTap: controller.showLogoutDialog,
                      iconColor: const Color(0xFFC8A45D),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        key: const ValueKey('settings_view_bottom_nav'),
        currentIndex: 4,
      ),
    );
  }
}

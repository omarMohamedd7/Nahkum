import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../widgets/settings_item.dart';
import '../widgets/user_profile_card.dart';
import '../widgets/custom_toggle_switch.dart';
import '../../../home/presentation/widgets/bottom_navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

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
              UserProfileCard(
                userName: 'أسم المستخدم',
                userEmail: 'username1234@gmail.com',
                onTap: () {
                  // Navigate to profile editing screen
                  AppRouter.instance.navigateToProfile(context);
                },
              ),

              // Settings items
              Expanded(
                child: ListView(
                  children: [
                    // Notifications setting
                    SettingsItem(
                      title: 'الإشعارات',
                      iconPath: 'assets/images/notification.svg',
                      onTap: () {
                        setState(() {
                          notificationsEnabled = !notificationsEnabled;
                        });
                      },
                      trailing: CustomToggleSwitch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      ),
                    ),

                    // Privacy policy
                    SettingsItem(
                      title: 'سياسة الخصوصية',
                      iconPath: 'assets/images/security.svg',
                      onTap: () {
                        // Navigate to privacy policy screen
                      },
                    ),

                    // About the app
                    SettingsItem(
                      title: 'حول التطبيق',
                      iconPath: 'assets/images/info-circle.svg',
                      onTap: () {
                        // Navigate to about app screen
                      },
                    ),

                    // Logout
                    SettingsItem(
                      title: 'تسجيل الخروج',
                      iconPath: 'assets/images/logout.svg',
                      onTap: () {
                        // Show logout confirmation dialog
                        _showLogoutDialog(context);
                      },
                      iconColor: const Color(0xFFC8A45D),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 4),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
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
                Navigator.of(context).pop();
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
                Navigator.of(context).pop();
                // Navigate to login screen
                AppRouter.instance.replaceWithLogin(context);
              },
            ),
          ],
        );
      },
    );
  }
}

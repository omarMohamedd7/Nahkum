import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../data/models/user_role.dart';
import '../controllers/onboarding_controller.dart';

class RoleTestPage extends GetView<OnboardingController> {
  const RoleTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختبار الأدوار'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اختر الدور للتسجيل',
                style: AppStyles.headingMedium,
              ),
              const SizedBox(height: 32),
              _buildRoleButton(
                title: 'عميل',
                role: UserRole.client,
              ),
              const SizedBox(height: 16),
              _buildRoleButton(
                title: 'محامي',
                role: UserRole.lawyer,
              ),
              const SizedBox(height: 16),
              _buildRoleButton(
                title: 'قاضي',
                role: UserRole.judge,
              ),
              const SizedBox(height: 32),
              Obx(() {
                final selectedRole = controller.selectedRole.value;
                if (selectedRole == null) {
                  return const Text('لم يتم اختيار دور بعد');
                } else {
                  return Text(
                    'تم اختيار: ${selectedRole.getArabicName()}',
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String title,
    required UserRole role,
  }) {
    return CustomButton(
      text: title,
      onTap: () {
        controller.selectRole(role);
        controller.navigateToRegister(role);
      },
      isLoading: false,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
    );
  }
}

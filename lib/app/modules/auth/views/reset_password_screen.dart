import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/theme/app_colors.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/utils/form_validator.dart';
import 'package:legal_app/app/global_widgets/custom_button.dart';
import 'package:legal_app/app/global_widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordScreen extends GetView<AuthController> {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/arrow-right.svg',
              color: AppColors.primary,
            ),
            onPressed: () => Get.back(),
          ),
        ],
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = isSmallScreen ? 24.0 : 80.0;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Form(
                  key: controller.resetPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header section
                      Container(
                        width: double.infinity,
                        child: Text(
                          'إعادة تعيين كلمة المرور',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontSize: isSmallScreen ? 24 : 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'أدخل كلمة المرور الجديدة',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontSize: isSmallScreen ? 16 : 18,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // New password field
                      CustomTextField(
                        hintText: 'أدخل كلمة المرور الجديدة',
                        labelText: 'كلمة المرور الجديدة',
                        iconPath: 'assets/images/lock_icon.svg',
                        controller: controller.newPasswordController,
                        isPassword: true,
                        validator: FormValidators.validateStrongPassword,
                      ),

                      const SizedBox(height: 16),

                      // Confirm password field
                      CustomTextField(
                        hintText: 'أكد كلمة المرور الجديدة',
                        labelText: 'تأكيد كلمة المرور',
                        iconPath: 'assets/images/shield-tick.svg',
                        controller: controller.confirmNewPasswordController,
                        isPassword: true,
                        validator: (value) =>
                            FormValidators.validateConfirmPassword(
                                value, controller.newPasswordController.text),
                      ),

                      const SizedBox(height: 32),

                      // Submit button
                      SizedBox(
                        width: isSmallScreen
                            ? double.infinity
                            : screenSize.width * 0.5,
                        child: Obx(() => CustomButton(
                              text: 'حفظ',
                              onTap: () => _handleResetPassword(email),
                              isLoading: controller.isLoading.value,
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleResetPassword(String email) async {
    if (controller.resetPasswordFormKey.currentState?.validate() ?? false) {
      try {
        await controller.resetPassword(
            email, controller.newPasswordController.text);
        controller.showMessage('تم إعادة تعيين كلمة المرور بنجاح');
        // Navigate to success screen
        Get.offAllNamed(Routes.PASSWORD_RESET_SUCCESS);
      } catch (e) {
        controller.showMessage('فشل إعادة تعيين كلمة المرور', isError: true);
      }
    }
  }
}

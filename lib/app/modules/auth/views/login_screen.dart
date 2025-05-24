import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/utils/app_assets.dart';
import 'package:legal_app/app/utils/form_validator.dart';
import '../../../../app/errors/failure.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/utils/app_styles.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/login_header.dart';
import '../widgets/sign_up_link.dart';
import '../widgets/terms_checkbox.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';
import '../views/otp_verification_screen.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Padding(
              padding: AppStyles.horizontalPaddingLarge,
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const LoginHeader(compact: true),
                    Column(
                      children: [
                        CustomTextField(
                          hintText: 'أدخل بريد الكتروني فعال',
                          labelText: 'البريد الألكتروني',
                          iconPath: AppAssets.emailIcon,
                          controller: controller.emailLoginController,
                          keyboardType: TextInputType.emailAddress,
                          validator: FormValidators.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hintText: 'أدخل كلمة المرور الخاصة بك',
                          labelText: 'كلمة المرور',
                          iconPath: AppAssets.lock,
                          controller: controller.passwordLoginController,
                          isPassword: true,
                          validator: FormValidators.validatePassword,
                        ),
                        const SizedBox(height: 8),
                        ForgotPasswordLink(
                            onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD)),
                      ],
                    ),
                    Obx(() => TermsCheckbox(
                          value: controller.acceptTerms.value,
                          onChanged: (value) {
                            controller.setTermsAcceptance(value ?? false);
                          },
                        )),
                    Column(
                      children: [
                        Obx(() => CustomButton(
                              text: 'تسجيل الدخول',
                              onTap: _handleLogin,
                              isLoading: controller.isLoading.value,
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                            )),
                        const SizedBox(height: 16),
                        Obx(() => CustomButton(
                              text: 'سجل باستخدام غوغل',
                              onTap: _handleGoogleSignIn,
                              isLoading: controller.isLoading.value,
                              outlined: true,
                              backgroundColor: AppColors.white,
                              textColor: AppColors.primary,
                              leadingIconPath: AppAssets.google,
                            )),
                        const SizedBox(height: 16),
                        SignUpLink(onTap: () => Get.toNamed(Routes.REGISTER)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    // Manually validate form before proceeding
    if (controller.loginFormKey.currentState?.validate() != true) {
      controller.showMessage('يرجى ملء كافة  المطلوبة بشكل صحيح',
          isError: true);
      return;
    }

    if (!controller.acceptTerms.value) {
      controller.showMessage('يرجى الموافقة على الشروط والأحكام',
          isError: true);
      return;
    }

    try {
      await controller.login();

      // Navigate to OTP verification after successful login attempt
      Get.toNamed(Routes.OTP_VERIFICATION, arguments: {
        'email': controller.emailLoginController.text.trim(),
        'phoneNumber':
            "+1234567890", // In a real app, this would come from the user's profile or auth response
        'purpose': OtpVerificationPurpose.login,
      });
    } on AuthFailure catch (e) {
      controller.showMessage(e.message, isError: true);
    } catch (e) {
      controller.showMessage('فشل تسجيل الدخول', isError: true);
    }
  }

  void _handleGoogleSignIn() async {
    if (!controller.acceptTerms.value) {
      controller.showMessage('يرجى الموافقة على الشروط والأحكام',
          isError: true);
      return;
    }

    try {
      await controller.signInWithGoogle();
    } catch (e) {
      controller.showMessage('فشل تسجيل الدخول عبر حساب جوجل', isError: true);
    }
  }
}

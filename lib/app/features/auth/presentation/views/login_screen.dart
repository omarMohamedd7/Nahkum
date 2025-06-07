import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/core/utils/form_validator.dart';
import 'package:legal_app/app/core/utils/responsive_utils.dart';
import '../../../../errors/failure.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/login_header.dart';
import '../widgets/sign_up_link.dart';
import '../widgets/terms_checkbox.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';
import 'otp_verification_screen.dart';
import '../../../shared/onboarding/data/models/user_role.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;

    // Get the user role from arguments
    final Map<String, dynamic> args = Get.arguments ?? {};
    final UserRole? userRole = args['role'];

    // Debug print to verify the role is received
    print('Login Screen - Received role: ${userRole?.toString() ?? "null"}');

    // Update controller's user role
    if (userRole != null && controller.userRole.value != userRole) {
      controller.userRole.value = userRole;
      print(
          'Login Screen - Updated controller role to: ${userRole.toString()}');
    }

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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    screenSize.height - MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: AppStyles.horizontalPaddingLarge,
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height:
                              ResponsiveUtils.getHeightPercentage(context, 2)),
                      const LoginHeader(compact: true),
                      SizedBox(
                          height:
                              ResponsiveUtils.getHeightPercentage(context, 3)),
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
                          SizedBox(
                              height: ResponsiveUtils.getHeightPercentage(
                                  context, 2)),
                          CustomTextField(
                            hintText: 'أدخل كلمة المرور الخاصة بك',
                            labelText: 'كلمة المرور',
                            iconPath: AppAssets.lock,
                            controller: controller.passwordLoginController,
                            isPassword: true,
                            validator: FormValidators.validatePassword,
                          ),
                          SizedBox(
                              height: ResponsiveUtils.getHeightPercentage(
                                  context, 1)),
                          ForgotPasswordLink(
                              onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD)),
                        ],
                      ),
                      SizedBox(
                          height:
                              ResponsiveUtils.getHeightPercentage(context, 2)),
                      Obx(() => TermsCheckbox(
                            value: controller.acceptTerms.value,
                            onChanged: (value) {
                              controller.setTermsAcceptance(value ?? false);
                            },
                          )),
                      SizedBox(
                          height:
                              ResponsiveUtils.getHeightPercentage(context, 3)),
                      Column(
                        children: [
                          Obx(() => CustomButton(
                                text: 'تسجيل الدخول',
                                onTap: _handleLogin,
                                isLoading: controller.isLoading.value,
                                backgroundColor: AppColors.primary,
                                textColor: AppColors.white,
                                height:
                                    ResponsiveUtils.getButtonHeight(context),
                              )),
                          SizedBox(
                              height: ResponsiveUtils.getHeightPercentage(
                                  context, 2)),
                          CustomButton(
                            text: 'سجل باستخدام غوغل',
                            onTap: _handleGoogleSignIn,
                            isLoading: false,
                            outlined: true,
                            backgroundColor: AppColors.white,
                            textColor: AppColors.primary,
                            leadingIconPath: AppAssets.google,
                            height: ResponsiveUtils.getButtonHeight(context),
                          ),
                          SizedBox(
                              height: ResponsiveUtils.getHeightPercentage(
                                  context, 2)),
                          SignUpLink(
                            onTap: () {
                              // Make sure we pass the role to the registration screen
                              final roleToPass =
                                  controller.userRole.value ?? userRole;
                              print(
                                  'Navigating to register with role: ${roleToPass?.toString() ?? "null"}');

                              // Ensure the role is set in the controller before navigation
                              if (roleToPass != null) {
                                controller.userRole.value = roleToPass;
                              }

                              Get.toNamed(
                                Routes.REGISTER,
                                arguments: {'role': roleToPass},
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              ResponsiveUtils.getHeightPercentage(context, 2)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    print("Login button pressed");

    if (controller.loginFormKey.currentState?.validate() != true) {
      print("Login validation failed");
      return;
    }

    if (!controller.acceptTerms.value) {
      print("Terms not accepted");
      Get.snackbar(
        'تنبيه',
        'يرجى الموافقة على الشروط والأحكام',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      print(
          "Calling controller.login() with role: ${controller.userRole.value?.toString() ?? 'null'}");
      // Call controller login method - the controller will handle navigation
      await controller.login();
      print("Controller login method completed");

      // Let the controller handle navigation based on user role
      // Do NOT navigate to OTP or any other screen here
    } catch (e) {
      print("Login error: $e");
      // Handle only critical errors that prevent navigation
      if (e is AuthFailure) {
        Get.snackbar('خطأ', e.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  void _handleGoogleSignIn() async {
    if (!controller.acceptTerms.value) {
      Get.snackbar(
        'تنبيه',
        'يرجى الموافقة على الشروط والأحكام',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await controller.signInWithGoogle();
    } catch (e) {
      if (e is AuthFailure) {
        Get.snackbar('خطأ', e.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}

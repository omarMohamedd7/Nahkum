import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/shared/widgets/custom_button.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/utils/form_validator.dart';
import 'package:legal_app/app/shared/widgets/custom_text_field.dart';
import 'otp_verification_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Method to handle password reset request
  void _handleResetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Simulate API call with delay
        await Future.delayed(const Duration(seconds: 2));

        // Here you would call your actual password reset service
        final email = _emailController.text.trim();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إرسال رمز التحقق إلى بريدك الإلكتروني'),
              backgroundColor: AppColors.success,
            ),
          );

          // Navigate to OTP verification screen after sending the reset code
          // Include the purpose parameter to ensure correct navigation flow
          Get.toNamed(
            Routes.OTP_VERIFICATION,
            arguments: {
              'email': email,
              'phoneNumber': '',
              'purpose': OtpVerificationPurpose.resetPassword,
            },
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل إرسال رابط إعادة التعيين: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

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
              AppAssets.arrowRight,
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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header section
                      Container(
                        width: double.infinity,
                        child: Text(
                          'هل نسيت كلمة المرور؟',
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          'يرجى إدخال بريدك الإلكتروني لاستعادة كلمة المرور',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Email field
                      CustomTextField(
                        hintText: 'أدخل بريد الكتروني فعال',
                        labelText: 'البريد الألكتروني',
                        iconPath: AppAssets.emailIcon,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: FormValidators.validateEmail,
                      ),
                      const SizedBox(height: 32),

                      // Submit button
                      SizedBox(
                        width: isSmallScreen
                            ? double.infinity
                            : screenSize.width * 0.5,
                        child: CustomButton(
                          text: 'إرسال',
                          onTap: _handleResetPassword,
                          isLoading: _isLoading,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        ),
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
}

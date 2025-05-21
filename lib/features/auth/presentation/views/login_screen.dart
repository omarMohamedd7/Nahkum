import 'package:flutter/material.dart';
import 'package:legal_app/core/utils/app_assets.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/auth_controller.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/login_header.dart';
import '../widgets/sign_up_link.dart';
import '../widgets/terms_checkbox.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/form_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;
  bool _isLoading = false;

  // Simple controller for placeholder functionality
  final _authController = AuthController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_acceptTerms) {
        _showMessage('يرجى الموافقة على الشروط والأحكام', isError: true);
        return;
      }

      setState(() => _isLoading = true);

      try {
        await _authController.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );
        _showMessage('تم تسجيل الدخول بنجاح');

        // Navigate to login-specific OTP verification screen
        AppRouter.instance.navigateToLoginOtpVerification(
          context,
          _emailController.text.trim(),
          "+1234567890", // In a real app, this would come from the user's profile or auth response
        );
      } catch (e) {
        if (e is AuthFailure) {
          _showMessage(e.message, isError: true);
        } else if (e is NetworkFailure) {
          _showMessage(e.message, isError: true);
        } else if (e is ServerFailure) {
          _showMessage(e.message, isError: true);
        } else {
          _showMessage('فشل تسجيل الدخول', isError: true);
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleGoogleSignIn() async {
    if (!_acceptTerms) {
      _showMessage('يرجى الموافقة على الشروط والأحكام', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authController.signInWithGoogle();
      _showMessage('تم تسجيل الدخول بنجاح عبر حساب جوجل');
    } catch (e) {
      if (e is AuthFailure) {
        _showMessage(e.message, isError: true);
      } else if (e is NetworkFailure) {
        _showMessage(e.message, isError: true);
      } else {
        _showMessage('فشل تسجيل الدخول عبر حساب جوجل', isError: true);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleForgotPassword() {
    // Navigate to the forget password screen using AppRouter
    AppRouter.instance.navigateToForgetPassword(context);
  }

  void _handleSignUp() {
    // Placeholder for sign up navigation
    debugPrint('Navigate to sign up screen');
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
      ),
    );
  }

  @override
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const LoginHeader(compact: true),
                    Column(
                      children: [
                        CustomTextField(
                          hintText: 'أدخل بريد الكتروني فعال',
                          labelText: 'البريد الألكتروني',
                          iconPath: 'assets/images/email_icon.svg',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: FormValidators.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hintText: 'أدخل كلمة المرور الخاصة بك',
                          labelText: 'كلمة المرور',
                          iconPath: 'assets/images/lock_icon.svg',
                          controller: _passwordController,
                          isPassword: true,
                          validator: FormValidators.validatePassword,
                        ),
                        const SizedBox(height: 8),
                        ForgotPasswordLink(onTap: _handleForgotPassword),
                      ],
                    ),
                    TermsCheckbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                    ),
                    Column(
                      children: [
                        CustomButton(
                          text: 'تسجيل الدخول',
                          onTap: _handleLogin,
                          isLoading: _isLoading,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'سجل باستخدام غوغل',
                          onTap: _handleGoogleSignIn,
                          outlined: true,
                          backgroundColor: AppColors.white,
                          textColor: AppColors.primary,
                          leadingIconPath: 'assets/images/google_icon.svg',
                        ),
                        const SizedBox(height: 16),
                        SignUpLink(onTap: _handleSignUp),
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
}

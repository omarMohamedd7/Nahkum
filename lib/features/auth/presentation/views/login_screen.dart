import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/auth_controller.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/login_header.dart';
import '../widgets/sign_up_link.dart';
import '../widgets/terms_checkbox.dart';
import 'forget_password_screen.dart';
import '../../../../core/utils/app_router.dart';

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

      // Placeholder for login logic
      try {
        await _authController.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );
        _showMessage('تم تسجيل الدخول بنجاح');
      } catch (e) {
        _showMessage('فشل تسجيل الدخول', isError: true);
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

    // Placeholder for Google Sign-In
    try {
      await _authController.signInWithGoogle();
      _showMessage('تم تسجيل الدخول بنجاح عبر حساب جوجل');
    } catch (e) {
      _showMessage('فشل تسجيل الدخول عبر حساب جوجل', isError: true);
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
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.ScreenBackground,
        ),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: LayoutBuilder(builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;
              final horizontalPadding = isSmallScreen ? 24.0 : 80.0;

              return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          LoginHeader(compact: true),
                          const SizedBox(
                              height: 8), // Between title and subtitle
                          const SizedBox(height: 10), // After subtitle

                          CustomTextField(
                            hintText: 'أدخل بريد الكتروني فعال',
                            labelText: 'البريد الألكتروني',
                            iconPath: 'assets/images/email_icon.svg',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال البريد الإلكتروني';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'يرجى إدخال بريد إلكتروني صحيح';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          CustomTextField(
                            hintText: 'أدخل كلمة المرور الخاصة بك',
                            labelText: 'كلمة المرور',
                            iconPath: 'assets/images/lock_icon.svg',
                            controller: _passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور';
                              }
                              if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 8),

                          ForgotPasswordLink(onTap: _handleForgotPassword),

                          const SizedBox(height: 24),

                          TermsCheckbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value ?? false;
                              });
                            },
                          ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: 'تسجيل الدخول',
                            onTap: () => AppRouter.instance
                                .navigateToOtpVerification(
                                    context, "user@example.com", "+1234567890"),
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

                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: SignUpLink(onTap: _handleSignUp),
                          ),
                        ],
                      )));
            }),
          ),
        ),
      ),
    );
  }
}

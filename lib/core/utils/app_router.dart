import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/forget_password_screen.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/register_screen.dart'; // ✅ Import register screen
import '../../features/auth/presentation/views/otp_verification_screen.dart'; // ✅ Import OTP screen
import '../../features/auth/presentation/views/reset_password_screen.dart'; // ✅ Import Reset Password screen
import '../../features/auth/presentation/views/password_reset_success_screen.dart'; // ✅ Import Password Reset Success screen

class AppRouter {
  // Route names
  static const String loginRoute = '/login';
  static const String forgetPasswordRoute = '/forget-password';
  static const String registerRoute = '/register';
  static const String otpVerificationRoute =
      '/otp-verification'; // ✅ OTP route name
  static const String resetPasswordRoute =
      '/reset-password'; // ✅ Reset Password route name
  static const String passwordResetSuccessRoute =
      '/password-reset-success'; // ✅ Success route name

  // Private constructor
  AppRouter._();

  // Singleton instance
  static final AppRouter _instance = AppRouter._();
  static AppRouter get instance => _instance;

  // Route generation
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case registerRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterScreen()); // ✅ Register route

      case otpVerificationRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            email: args['email'] as String,
            phoneNumber: args['phoneNumber'] as String,
          ),
        ); // ✅ OTP verification route

      case resetPasswordRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(
            email: args['email'] as String,
          ),
        ); // ✅ Reset Password route

      case passwordResetSuccessRoute:
        return MaterialPageRoute(
          builder: (_) => const PasswordResetSuccessScreen(),
        ); // ✅ Success screen route

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // Navigation methods
  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(loginRoute);
  }

  void navigateToForgetPassword(BuildContext context) {
    Navigator.of(context).pushNamed(forgetPasswordRoute);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(registerRoute); // ✅ New method
  }

  void navigateToOtpVerification(
      BuildContext context, String email, String phoneNumber) {
    Navigator.of(context).pushNamed(
      otpVerificationRoute,
      arguments: {
        'email': email,
        'phoneNumber': phoneNumber,
      },
    );
  }

  void navigateToResetPassword(BuildContext context, String email) {
    Navigator.of(context).pushNamed(
      resetPasswordRoute,
      arguments: {
        'email': email,
      },
    );
  }

  void navigateToPasswordResetSuccess(BuildContext context) {
    Navigator.of(context).pushNamed(passwordResetSuccessRoute);
  }

  void replaceWithPasswordResetSuccess(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(passwordResetSuccessRoute);
  }

  void replaceWithLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(loginRoute);
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}

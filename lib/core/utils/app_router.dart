import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/forget_password_screen.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/register_screen.dart'; // ✅ Import register screen
import '../../features/auth/presentation/views/otp_verification_screen.dart'; // ✅ Import OTP screen
import '../../features/auth/presentation/views/reset_password_screen.dart'; // ✅ Import Reset Password screen
import '../../features/auth/presentation/views/password_reset_success_screen.dart'; // ✅ Import Password Reset Success screen
import '../../features/home/presentation/views/home_page.dart'; // ✅ Import home page
import '../../features/home/presentation/views/lawyers_listing_page.dart'; // ✅ Import lawyers listing page
import '../../features/direct case request/presentation/views/direct_case_request.dart'; // ✅ Import direct case request page
import '../../features/Publish Case/presentation/views/publish_case.dart'; // ✅ Import publish case page
import '../../features/consultation/presentation/views/consultation_request_page.dart'; // ✅ Import consultation request page
import '../../features/home/domain/entities/lawyer.dart'; // ✅ Import lawyer entity
import '../../features/case_management/presentation/views/cases_page.dart'; // ✅ Import cases page
import '../../features/case_management/presentation/views/case_details/case_details_page.dart'; // ✅ Import case details page
import '../../features/case_management/domain/entities/case.dart'; // ✅ Import case entity
import '../../features/notifications/presentation/views/notifications_screen.dart'; // ✅ Import notifications screen
import '../../features/settings/presentation/views/settings_screen.dart'; // ✅ Import settings screen
import '../../features/profile/presentation/views/profile_screen.dart'; // ✅ Import profile screen
import '../../features/chat/presentation/views/chats_screen.dart'; // ✅ Import chats screen
import '../../features/chat/domain/entities/chat.dart'; // ✅ Import chat entity
import '../../features/chat/presentation/views/chat_detail_screen.dart'; // ✅ Import chat detail screen

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
  static const String homeRoute = '/home'; // ✅ Home route name
  static const String publishCaseRoute =
      '/publish-case'; // ✅ Publish case route name
  static const String directCaseRequestRoute =
      '/direct-case-request'; // ✅ Direct case request route name
  static const String lawyersListingRoute =
      '/lawyers-listing'; // ✅ Lawyers listing route name
  static const String consultationRequestRoute =
      '/consultation-request'; // ✅ Consultation request route name
  static const String casesRoute = '/cases'; // ✅ Cases route name
  static const String caseDetailsRoute =
      '/case-details'; // ✅ Case details route name
  static const String notificationsRoute =
      '/notifications'; // ✅ Notifications route name
  static const String settingsRoute = '/settings'; // ✅ Settings route name
  static const String profileRoute = '/profile'; // ✅ Profile route name
  static const String chatsRoute = '/chats'; // ✅ Chats route name
  static const String chatDetailRoute =
      '/chat-detail'; // ✅ Chat detail route name

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
            purpose: args['purpose'] as OtpVerificationPurpose,
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

      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        ); // ✅ Home page route

      case publishCaseRoute:
        return MaterialPageRoute(
          builder: (_) => const PublishCase(),
        ); // ✅ Publish case page route

      case directCaseRequestRoute:
        return MaterialPageRoute(
          builder: (_) => const DirectCaseRequest(),
        ); // ✅ Direct case request page route

      case lawyersListingRoute:
        return MaterialPageRoute(
          builder: (_) => const LawyersListingPage(),
        ); // ✅ Lawyers listing page route

      case consultationRequestRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ConsultationRequestPage(
            lawyer: args?['lawyer'] as Lawyer?,
          ),
        ); // ✅ Consultation request page route

      case casesRoute:
        return MaterialPageRoute(
          builder: (_) => const CasesPage(),
        ); // ✅ Cases page route

      case caseDetailsRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CaseDetailsPage(
            caseItem: args['caseItem'] as Case,
          ),
        ); // ✅ Case details page route

      case notificationsRoute:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        ); // ✅ Notifications screen route

      case settingsRoute:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        ); // ✅ Settings screen route

      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ); // ✅ Profile screen route

      case chatsRoute:
        return MaterialPageRoute(
          builder: (_) => const ChatsScreen(),
        ); // ✅ Chats screen route

      case chatDetailRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChatDetailScreen(
            chat: args['chat'] as Chat,
          ),
        ); // ✅ Chat detail screen route

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

  // Navigate to OTP verification for login flow
  void navigateToLoginOtpVerification(
      BuildContext context, String email, String phoneNumber) {
    Navigator.of(context).pushNamed(
      otpVerificationRoute,
      arguments: {
        'email': email,
        'phoneNumber': phoneNumber,
        'purpose': OtpVerificationPurpose.login,
      },
    );
  }

  // Navigate to OTP verification for password reset flow
  void navigateToResetPasswordOtpVerification(
      BuildContext context, String email, String phoneNumber) {
    Navigator.of(context).pushNamed(
      otpVerificationRoute,
      arguments: {
        'email': email,
        'phoneNumber': phoneNumber,
        'purpose': OtpVerificationPurpose.resetPassword,
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

  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamed(homeRoute);
  }

  void navigateToPublishCase(BuildContext context) {
    Navigator.of(context).pushNamed(publishCaseRoute);
  }

  void navigateToLawyersListing(BuildContext context) {
    Navigator.of(context).pushNamed(lawyersListingRoute);
  }

  void navigateToConsultationRequest(BuildContext context, {Lawyer? lawyer}) {
    Navigator.of(context).pushNamed(
      consultationRequestRoute,
      arguments: {
        'lawyer': lawyer,
      },
    );
  }

  void navigateToDirectCaseRequest(BuildContext context) {
    Navigator.of(context).pushNamed(directCaseRequestRoute);
  }

  void navigateToCasesPage(BuildContext context) {
    Navigator.of(context).pushNamed(casesRoute);
  }

  void navigateToCaseDetails(BuildContext context, Case caseItem) {
    Navigator.of(context).pushNamed(
      caseDetailsRoute,
      arguments: {
        'caseItem': caseItem,
      },
    );
  }

  void replaceWithPasswordResetSuccess(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(passwordResetSuccessRoute);
  }

  void replaceWithLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(loginRoute);
  }

  void replaceWithHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(homeRoute);
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void navigateToNotifications(BuildContext context) {
    Navigator.of(context).pushNamed(notificationsRoute);
  }

  void navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed(settingsRoute);
  }

  void navigateToProfile(BuildContext context) {
    Navigator.of(context).pushNamed(profileRoute);
  }

  void navigateToChats(BuildContext context) {
    Navigator.of(context).pushNamed(chatsRoute);
  }

  void navigateToChatDetail(BuildContext context, Chat chat) {
    Navigator.of(context).pushNamed(
      chatDetailRoute,
      arguments: {
        'chat': chat,
      },
    );
  }
}

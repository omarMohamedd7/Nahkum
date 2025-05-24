import 'package:get/get.dart';
import 'package:legal_app/app/modules/auth/views/forget_password_screen.dart';
import 'package:legal_app/app/modules/auth/views/login_screen.dart';
import 'package:legal_app/app/modules/auth/views/otp_verification_screen.dart';
import 'package:legal_app/app/modules/auth/views/password_reset_success_screen.dart';
import 'package:legal_app/app/modules/auth/views/register_screen.dart';
import 'package:legal_app/app/modules/auth/views/register_success_screen.dart';
import 'package:legal_app/app/modules/auth/views/reset_password_screen.dart';
import 'package:legal_app/app/modules/publish_case/bindings/publish_case_binding.dart';
import 'package:legal_app/app/modules/home/widgets/lawyers_listing_page.dart';
import 'app_routes.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chats_view.dart';
import '../modules/chat/views/chat_detail_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/consultation/bindings/consultation_binding.dart';
import '../modules/consultation/views/consultation_view.dart';
import '../modules/case_management/bindings/case_management_binding.dart';
import '../modules/case_management/views/case_management_view.dart';
import '../modules/direct_case_request/bindings/direct_case_request_binding.dart';
import '../modules/direct_case_request/views/direct_case_request_view.dart';
import '../modules/publish_case/views/publish_case_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

class AppPages {
  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.OTP_VERIFICATION,
      page: () {
        final args = Get.arguments ?? {};
        return OtpVerificationScreen(
          email: args['email'] ?? '',
          phoneNumber: args['phoneNumber'] ?? '',
          purpose: args['purpose'] ?? OtpVerificationPurpose.login,
        );
      },
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () {
        final args = Get.arguments ?? {};
        return ResetPasswordScreen(
          email: args['email'] ?? '',
        );
      },
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.PASSWORD_RESET_SUCCESS,
      page: () => const PasswordResetSuccessScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_SUCCESS,
      page: () {
        final args = Get.arguments ?? {};
        return RegisterSuccessScreen(
          email: args['email'] ?? '',
        );
      },
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.CHATS,
      page: () => ChatsView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.CHAT_DETAIL,
      page: () => ChatDetailView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.CONSULTATION_REQUEST,
      page: () => const ConsultationView(),
      binding: ConsultationBinding(),
    ),
    GetPage(
      name: Routes.CASES,
      page: () => const CaseManagementView(),
      binding: CaseManagementBinding(),
    ),
    GetPage(
      name: Routes.DIRECT_CASE_REQUEST,
      page: () => const DirectCaseRequestView(),
      binding: DirectCaseRequestBinding(),
    ),
    GetPage(
      name: Routes.PUBLISH_CASE,
      page: () => const PublishCaseView(),
      binding: PublishCaseBinding(),
    ),
    GetPage(
      name: Routes.LAWYERS_LISTING,
      page: () => const LawyersListingPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    // Add more pages here
  ];
}

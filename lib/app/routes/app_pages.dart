import 'package:get/get.dart';
import 'package:legal_app/app/features/auth/presentation/views/forget_password_screen.dart';
import 'package:legal_app/app/features/auth/presentation/views/login_screen.dart';
import 'package:legal_app/app/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:legal_app/app/features/auth/presentation/views/password_reset_success_screen.dart';
import 'package:legal_app/app/features/auth/presentation/views/register_screen.dart';
import 'package:legal_app/app/features/auth/presentation/views/register_success_screen.dart';
import 'package:legal_app/app/features/auth/presentation/views/reset_password_screen.dart';
import 'package:legal_app/app/features/client/case_management/presentation/views/case_management_view.dart';
import 'package:legal_app/app/features/client/publish_case/presentation/bindings/publish_case_binding.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/lawyers_listing_page.dart';
import 'package:legal_app/app/features/client/case_offer/presentation/views/case_offer_detail_view.dart';
import 'package:legal_app/app/features/client/case_offer/presentation/bindings/case_offer_binding.dart';
import 'package:legal_app/app/features/client/case_offer/presentation/views/case_offer_list_view.dart';
import 'package:legal_app/app/features/client/case_offer/presentation/bindings/case_offer_list_binding.dart';
import 'package:legal_app/app/features/shared/chat/presentation/bindings/chat_binding.dart';
import 'package:legal_app/app/features/shared/chat/presentation/views/chat_detail_view.dart';
import 'package:legal_app/app/features/shared/notifications/presentation/bindings/notifications_binding.dart';
import 'package:legal_app/app/features/shared/onboarding/presentation/bindings/onboarding_binding.dart';
import 'package:legal_app/app/features/shared/onboarding/presentation/views/role_test_page.dart';
import 'package:legal_app/app/features/shared/profile/presentation/bindings/profile_binding.dart';
import 'package:legal_app/app/features/shared/settings/presentation/bindings/settings_binding.dart';
import 'app_routes.dart';
import '../features/client/home/presentation/bindings/home_binding.dart';
import '../features/client/home/presentation/views/home_view.dart';
import '../features/auth/presentation/bindings/auth_binding.dart';
import '../features/shared/profile/presentation/views/profile_view.dart';
import '../features/shared/chat/presentation/views/chats_view.dart';
import '../features/shared/settings/presentation/views/settings_view.dart';
import '../features/shared/notifications/presentation/views/notifications_view.dart';
import '../features/client/consultation/presentation/bindings/consultation_binding.dart';
import '../features/client/consultation/presentation/views/consultation_view.dart';
import '../features/client/case_management/presentation/bindings/case_management_binding.dart';
import '../features/client/direct_case_request/presentation/bindings/direct_case_request_binding.dart';
import '../features/client/direct_case_request/presentation/views/direct_case_request_view.dart';
import '../features/client/publish_case/presentation/views/publish_case_view.dart';
import '../features/shared/onboarding/presentation/views/onboarding_view.dart';

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
    GetPage(
      name: Routes.ROLE_TEST,
      page: () => const RoleTestPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.CASE_OFFER_DETAIL,
      page: () => const CaseOfferDetailView(),
      binding: CaseOfferBinding(),
    ),
    GetPage(
      name: Routes.CASE_DETAILS,
      page: () => const CaseOfferListView(),
      binding: CaseOfferListBinding(),
    ),
    // Add more pages here
  ];
}

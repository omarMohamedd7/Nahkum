import 'package:get/get.dart';
import 'package:legal_app/app/features/Judge/home/presentation/views/blogs_view.dart';
import 'package:legal_app/app/features/Judge/home/presentation/views/judge_home_view.dart';
import 'package:legal_app/app/features/Judge/home/presentation/views/tasks_view.dart';
import 'package:legal_app/app/features/Judge/home/presentation/views/video_analysis_view.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/views/agencies_view.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/views/my_cases_view.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/views/home_view.dart'
    as LawyerHome;
import 'package:legal_app/app/features/Lawer/home/presentation/views/clients_view.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/views/my_orders_view.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/bindings/cases_binding.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/bindings/my_orders_binding.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/bindings/lawyer_home_binding.dart';
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
import 'package:legal_app/app/features/splash/presentation/bindings/splash_binding.dart';
import 'package:legal_app/app/features/splash/presentation/views/splash_view.dart';
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
import 'package:legal_app/app/features/Lawer/home/presentation/bindings/clients_binding.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/bindings/agencies_binding.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/bindings/submit_offer_binding.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/views/submit_offer_view.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      transition: Transition.noTransition,
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
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
      transition: Transition.noTransition,
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
      transition: Transition.noTransition,
      name: Routes.PASSWORD_RESET_SUCCESS,
      page: () => const PasswordResetSuccessScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
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
      transition: Transition.noTransition,
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.CHATS,
      page: () => ChatsView(),
      binding: ChatBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.CHAT_DETAIL,
      page: () => ChatDetailView(),
      binding: ChatBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.CONSULTATION_REQUEST,
      page: () => const ConsultationView(),
      binding: ConsultationBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.CASES,
      page: () => const CaseManagementView(),
      binding: CaseManagementBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.DIRECT_CASE_REQUEST,
      page: () => const DirectCaseRequestView(),
      binding: DirectCaseRequestBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.PUBLISH_CASE,
      page: () => const PublishCaseView(),
      binding: PublishCaseBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYERS_LISTING,
      page: () => const LawyersListingPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.ROLE_TEST,
      page: () => const RoleTestPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.CASE_OFFER_DETAIL,
      page: () => const CaseOfferDetailView(),
      binding: CaseOfferBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.CASE_DETAILS,
      page: () => const CaseOfferListView(),
      binding: CaseOfferListBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYER_HOME,
      page: () => const LawyerHome.HomeView(),
      binding: LawyerHomeBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYER_CLIENTS,
      page: () => const ClientsView(),
      binding: ClientsBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYER_CASES,
      page: () => const MyCasesView(),
      binding: CasesBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYER_AGENCIES,
      page: () => const AgenciesView(),
      binding: AgenciesBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYER_ORDERS,
      page: () => const MyOrdersView(),
      binding: MyOrdersBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.LAWYER_SUBMIT_OFFER,
      page: () => const SubmitOfferView(),
      binding: SubmitOfferBinding(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.Judge_HOME,
      page: () => const JudgeHomeView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.Tasks_View,
      page: () => const TasksView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.Video_Analysis_View,
      page: () => const VideoAnalysisView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.Blogs_View,
      page: () => const BlogsView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      name: Routes.Agencies_View,
      page: () => const AgenciesView(),
    ),
  ];
}

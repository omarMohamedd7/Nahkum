// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:legal_app/app/routes/app_routes.dart';
// import 'package:legal_app/app/theme/app_colors.dart';
// import 'package:legal_app/app/utils/app_styles.dart';
// import 'package:legal_app/app/global_widgets/custom_button.dart';
// import 'package:legal_app/app/global_widgets/custom_text_field.dart';
// import 'package:legal_app/app/utils/form_validator.dart';
// import '../controllers/auth_controller.dart';
// import '../widgets/forgot_password_link.dart';
// import '../widgets/login_header.dart';
// import '../widgets/sign_up_link.dart';
// import '../widgets/terms_checkbox.dart';

// class LoginView extends GetView<AuthController> {
//   const LoginView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       appBar: AppBar(
//         backgroundColor: AppColors.ScreenBackground,
//         elevation: 0,
//         toolbarHeight: 0,
//       ),
//       body: SafeArea(
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Center(
//             child: Padding(
//               padding: AppStyles.horizontalPaddingLarge,
//               child: Form(
//                 key: controller.loginFormKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const LoginHeader(compact: true),
//                     Column(
//                       children: [
//                         CustomTextField(
//                           hintText: 'أدخل بريد الكتروني فعال',
//                           labelText: 'البريد الألكتروني',
//                           iconPath: 'assets/images/email_icon.svg',
//                           controller: controller.emailLoginController,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: FormValidators.validateEmail,
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextField(
//                           hintText: 'أدخل كلمة المرور الخاصة بك',
//                           labelText: 'كلمة المرور',
//                           iconPath: 'assets/images/lock_icon.svg',
//                           controller: controller.passwordLoginController,
//                           isPassword: true,
//                           validator: FormValidators.validatePassword,
//                         ),
//                         const SizedBox(height: 8),
//                         ForgotPasswordLink(
//                           onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
//                         ),
//                       ],
//                     ),
//                     Obx(() => TermsCheckbox(
//                           value: controller.acceptTerms.value,
//                           onChanged: (value) =>
//                               controller.setTermsAcceptance(value ?? false),
//                         )),
//                     Column(
//                       children: [
//                         Obx(() => CustomButton(
//                               text: 'تسجيل الدخول',
//                               onTap: controller.login,
//                               isLoading: controller.isLoading.value,
//                               backgroundColor: AppColors.primary,
//                               textColor: AppColors.white,
//                             )),
//                         const SizedBox(height: 16),
//                         Obx(() => CustomButton(
//                               text: 'سجل باستخدام غوغل',
//                               onTap: controller.signInWithGoogle,
//                               isLoading: controller.isLoading.value,
//                               outlined: true,
//                               backgroundColor: AppColors.white,
//                               textColor: AppColors.primary,
//                               leadingIconPath: 'assets/images/google_icon.svg',
//                             )),
//                         const SizedBox(height: 16),
//                         SignUpLink(
//                           onTap: () => Get.toNamed(Routes.REGISTER),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

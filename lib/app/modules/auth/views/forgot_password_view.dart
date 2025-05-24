// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:legal_app/app/theme/app_colors.dart';
// import 'package:legal_app/app/utils/form_validator.dart';
// import 'package:legal_app/app/global_widgets/custom_button.dart';
// import 'package:legal_app/app/global_widgets/custom_text_field.dart';
// import '../controllers/auth_controller.dart';

// class ForgotPasswordView extends GetView<AuthController> {
//   const ForgotPasswordView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.ScreenBackground,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.primary),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text(
//           'نسيت كلمة المرور',
//           style: TextStyle(
//             color: AppColors.primary,
//             fontFamily: 'Almarai',
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: controller.forgotPasswordFormKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     'assets/images/forgot_password.svg',
//                     height: 150,
//                   ),
//                   const SizedBox(height: 32),
//                   const Text(
//                     'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور',
//                     style: TextStyle(
//                       fontFamily: 'Almarai',
//                       fontSize: 16,
//                       color: AppColors.textPrimary,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 24),
//                   CustomTextField(
//                     hintText: 'أدخل بريد الكتروني فعال',
//                     labelText: 'البريد الألكتروني',
//                     iconPath: 'assets/images/email_icon.svg',
//                     controller: controller.emailForgotController,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: FormValidators.validateEmail,
//                   ),
//                   const SizedBox(height: 32),
//                   Obx(() => CustomButton(
//                         text: 'إرسال الرابط',
//                         onTap: controller.forgotPassword,
//                         isLoading: controller.isLoading.value,
//                         backgroundColor: AppColors.primary,
//                         textColor: AppColors.white,
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

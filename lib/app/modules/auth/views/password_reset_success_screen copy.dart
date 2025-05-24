import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:legal_app/app/global_widgets/custom_button.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/theme/app_colors.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Success icon
                    SizedBox(height: screenSize.height * 0.1),
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        color: AppColors.goldLight.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/check_circle.svg',
                          width: 64,
                          height: 64,
                          color: AppColors.goldLight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Success message
                    Text(
                      'تم إعادة تعيين كلمة المرور بنجاح',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: isSmallScreen ? 24 : 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'تم إعادة تعيين كلمة المرور الخاصة بك بنجاح، يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: isSmallScreen ? 16 : 18,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: screenSize.height * 0.15),

                    // Go to login button
                    SizedBox(
                      width: isSmallScreen
                          ? double.infinity
                          : screenSize.width * 0.5,
                      child: CustomButton(
                        text: 'الذهاب إلى تسجيل الدخول',
                        onTap: () => Get.offAllNamed(Routes.LOGIN),
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

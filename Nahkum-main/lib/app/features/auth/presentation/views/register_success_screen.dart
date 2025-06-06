import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/shared/widgets/custom_button.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';

class RegisterSuccessScreen extends StatelessWidget {
  final String email;

  const RegisterSuccessScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = isSmallScreen ? 24.0 : 80.0;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  50,
                  horizontalPadding,
                  MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Success icon
                    SvgPicture.asset(
                      AppAssets.checkCircle,
                      color: AppColors.success,
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(height: 32),

                    // Header section
                    Text(
                      'تم إنشاء الحساب بنجاح',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: isSmallScreen ? 24 : 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'تم إنشاء حسابك بنجاح. يمكنك الآن تسجيل الدخول للوصول إلى حسابك.',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Button to navigate to login
                    SizedBox(
                      width: isSmallScreen
                          ? double.infinity
                          : screenSize.width * 0.5,
                      child: CustomButton(
                        text: 'تسجيل الدخول',
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

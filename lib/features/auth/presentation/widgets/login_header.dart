import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  final bool compact;

  const LoginHeader({
    super.key,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/Logo.svg',
          height: compact ? 90 : 100,
          width: compact ? 90 : 100,
        ),
        const SizedBox(height: 15),
        const Text(
          'نرحب بك في نحكم',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'الرجاء تسجيل الدخول للوصول إلى حسابك',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 18,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

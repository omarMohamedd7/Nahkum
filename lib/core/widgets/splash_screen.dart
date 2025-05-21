import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/utils/app_assets.dart';
import 'package:legal_app/core/utils/app_router.dart';

class SplashScreen extends StatelessWidget {
  final Widget nextScreen;

  const SplashScreen({super.key, required this.nextScreen});

  void _navigateToNextScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      AppRouter.instance.navigateToOnboarding(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Schedule navigation once after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNextScreen(context);
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SvgPicture.asset(
            AppAssets.mainLogo,
            color: AppColors.goldLight,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

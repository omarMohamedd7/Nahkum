import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Wait for 2 seconds to display the splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to onboarding screen
    // In a real app, you would check if the user has seen onboarding before
    // and if they are logged in, then navigate accordingly
    Get.offAllNamed(Routes.ONBOARDING);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SvgPicture.asset(
            AppAssets.mainLogo,
            color: AppColors.goldLight,
            fit: BoxFit.contain,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}

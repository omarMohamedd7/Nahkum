import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/utils/app_router.dart';
import 'package:legal_app/features/onboarding/presentation/views/widgets/RoleButton%20.dart';
import 'package:legal_app/features/onboarding/presentation/views/widgets/continue_button.dart';
import '../../../home/presentation/views/home_page.dart';
import '../../data/models/user_role.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  UserRole? selectedRole;

  void selectRole(UserRole role) {
    setState(() => selectedRole = role);
  }

  void _navigateToHome() {
    AppRouter.instance.navigateToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isSmall = screen.width < 360 || screen.height < 640;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.5, 0.6),
            radius: 1.2,
            colors: [AppColors.primary.withOpacity(0.95), AppColors.primary],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmall ? 16.0 : 30.0,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Spacer(),
                          _buildLogo(isSmall),
                          SizedBox(height: isSmall ? 15.0 : 30.0),
                          _buildTitleText(isSmall),
                          SizedBox(height: isSmall ? 25.0 : 40.0),
                          _buildRoleButtons(isSmall),
                          const Spacer(flex: 2),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isSmall) {
    final width = isSmall ? 130.0 : 165.0;
    final height = isSmall ? 125.0 : 158.0;

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTitleText(bool isSmall) {
    final fontSize = isSmall ? 18.0 : 22.0;
    final lineHeight = (38 / 22) * fontSize;

    return Text(
      'يرجى اختيار الصفة التي تمثل دورك\nفي التطبيق',
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Almarai',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: lineHeight / fontSize,
      ),
    );
  }

  Widget _buildRoleButtons(bool isSmall) {
    final fontSize = isSmall ? 16.0 : 18.0;
    final buttonHeight = isSmall ? 48.0 : 56.0;

    return Column(
      children: [
        for (var role in UserRole.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RoleButton(
              role: role,
              isSelected: selectedRole == role,
              onTap: () => selectRole(role),
              fontSize: fontSize,
              height: buttonHeight,
            ),
          ),
        const SizedBox(height: 14),
        ContinueButton(
          onPressed: selectedRole != null ? _navigateToHome : null,
          fontSize: fontSize,
          height: buttonHeight,
        ),
      ],
    );
  }
}

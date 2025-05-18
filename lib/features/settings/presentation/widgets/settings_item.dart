import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color iconColor;

  const SettingsItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.trailing,
    this.iconColor = const Color(0xFFC8A45D), // Gold color from design
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 191, 191, 191),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Right side with arrow icon
            trailing ??
                SvgPicture.asset(
                  'assets/images/arrow-right.svg',
                  width: 20,
                  height: 20,
                  color: AppColors.textPrimary,
                ),

            // Left side with title and icon
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC8A45D).withOpacity(0.2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 18,
                      height: 18,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

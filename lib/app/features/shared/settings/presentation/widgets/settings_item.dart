import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.trailing,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // If there's a trailing widget like a toggle switch
              if (trailing != null) trailing!,

              // Spacer to push title and icon to the right
              const Spacer(),

              // Item title
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),

              // Icon with some spacing
              const SizedBox(width: 12),
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                color: iconColor ?? AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

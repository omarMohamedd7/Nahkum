import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool outlined;
  final Color? backgroundColor;
  final Color? textColor;
  final String? leadingIconPath;
  final double height;
  final double? width;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.outlined = false,
    this.backgroundColor,
    this.textColor,
    this.leadingIconPath,
    this.height = 48.0,
    this.width,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final buttonBackgroundColor =
        backgroundColor ?? (outlined ? Colors.transparent : AppColors.primary);
    final buttonTextColor =
        textColor ?? (outlined ? AppColors.primary : AppColors.white);

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            decoration: BoxDecoration(
              color: buttonBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: outlined
                  ? Border.all(color: AppColors.primary, width: 1.0)
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIconPath != null) ...[
                  SvgPicture.asset(
                    leadingIconPath!,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                ],
                if (isLoading)
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: buttonTextColor,
                      strokeWidth: 2,
                    ),
                  )
                else
                  Text(
                    text,
                    style: TextStyle(
                      color: buttonTextColor,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

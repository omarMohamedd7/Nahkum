import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class LawyerInfoCard extends StatelessWidget {
  final String lawyerName;
  final String lawyerImageUrl;
  final double? customHeight;

  const LawyerInfoCard({
    super.key,
    required this.lawyerName,
    required this.lawyerImageUrl,
    this.customHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 357,
      left: 24,
      child: Container(
        width: 392,
        height: customHeight ?? 74,
        decoration: BoxDecoration(
          color: AppColors.ScreenBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBFBFBF),
            width: 1,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              const SizedBox(width: 24),
              // Lawyer name - now first in RTL layout
              Text(
                lawyerName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(), // Push the image to the end
              // Lawyer profile image - now at the end in RTL layout
              CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset(lawyerImageUrl)),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}

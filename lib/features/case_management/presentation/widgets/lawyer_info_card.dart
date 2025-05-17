import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

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
    return Center(
      child: Container(
        width: 392,
        height: customHeight ?? 74,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBFBFBF),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Text(
                lawyerName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(lawyerImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

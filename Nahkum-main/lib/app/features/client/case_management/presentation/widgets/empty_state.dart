import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/custom_button.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const EmptyState({
    Key? key,
    required this.title,
    required this.message,
    required this.imagePath,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            SvgPicture.asset(
              imagePath,
              width: 120,
              height: 120,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Button
            CustomButton(
              text: buttonText,
              onTap: onButtonPressed,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}

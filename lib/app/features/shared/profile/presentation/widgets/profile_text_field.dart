import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;
  final bool isEditable;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.value,
    required this.iconPath,
    this.isEditable = false,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBFBFBF),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                iconPath,
                height: 20,
                width: 20,
                color: AppColors.textPrimary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          isEditable
              ? TextField(
                  controller: controller,
                  onChanged: onChanged,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'أدخل بياناتك هنا',
                  ),
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                )
              : Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
        ],
      ),
    );
  }
}

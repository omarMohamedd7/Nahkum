import 'package:flutter/material.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class CaseFileSection extends StatelessWidget {
  final String title;
  final String fileCount;

  const CaseFileSection({
    super.key,
    required this.title,
    required this.fileCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFC8A45D).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBFBFBF),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontFamily: 'Almarai',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fileCount,
            style: const TextStyle(
              color: Color(0xFF777777),
              fontFamily: 'Almarai',
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.fullscreen,
                size: 16,
                color: Color(0xFFC8A45D),
              ),
              const SizedBox(width: 4),
              Text(
                'عرض الصور',
                style: TextStyle(
                  color: const Color(0xFFC8A45D),
                  fontFamily: 'Almarai',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

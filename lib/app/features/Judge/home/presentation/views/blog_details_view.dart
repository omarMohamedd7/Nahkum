import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';

class BlogDetailsView extends StatelessWidget {
  const BlogDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              // Top Bar with title and back icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
                  Text(
                    'تفاصيل المرجع',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 32),

              // Icon + Title + Subtitle
              Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F0E6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.document,
                        width: 28,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'الموسوعة الجنائية العربية',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'عقوبات جنائية',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // نبذة عن الكتاب
              const Text(
                'نبذة عن الكتاب:',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'مرجع شامل ومتكامل يختص بشرح القوانين الجنائية العربية. '
                'يتناول الجرائم والعقوبات بتفصيل نظري وعملي، '
                'ويستعرض السوابق القضائية، والاجتهادات القانونية، مع شروح مبسطة لأحكام قانون العقوبات العام والخاص.',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  height: 1.6,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 24),

              // محتوى الكتاب
              const Text(
                'محتوى الكتاب:',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• المبادئ العامة في القانون الجنائي.\n'
                '• شرح تفصيلي للجرائم والعقوبات.\n'
                '• أمثلة من قضايا وسوابق قضائية عربية.\n'
                '• تحليل مواد قانون العقوبات في الدول العربية.',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  height: 1.6,
                ),
                textAlign: TextAlign.right,
              ),
              const Spacer(),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'تحميل',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

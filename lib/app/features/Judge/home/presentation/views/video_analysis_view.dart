import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Judge/home/presentation/widgets/custom_bottom_navigation_judge_Bar.dart';

class VideoAnalysisView extends StatelessWidget {
  const VideoAnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                'تحليل فيديو',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'قم برفع فيديو لتحليله باستخدام الذكاء الاصطناعي\nومراجعة نتائج الكشف عن الكذب.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Upload Area
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppAssets.document,
                      width: 36,
                      height: 36,
                      color: AppColors.gold,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'أختر من المعرض الفيديو الذي تريد تحليله',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'رفع فيديو',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'اسم الفيديو',
                  hintStyle: TextStyle(fontFamily: 'Almarai'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Fake Upload ProgressBar
              Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: LinearProgressIndicator(
                      value: 0.4,
                      backgroundColor: Color(0xFFF2F2F2),
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.close, size: 20, color: AppColors.textSecondary),
                ],
              ),
              const SizedBox(height: 24),

              // Uploaded Results
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'فيديوهات تم رفعها',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'نتيجة تحليل الفيديو',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'مدة الفيديو: 3:20 دقيقة',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'تاريخ الرفع: 18/5/2025',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'النظام يقدر أن الشخص كان صادقاً بنسبة  %78 خلال الفيديو.\nتحليل الذكاء الاصطناعي أظهر أن الشخص كان صادقاً في معظم الأجوبة، مع وجود فترات شك.',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavigationJudgeBar(currentIndex: 3),
    );
  }
}

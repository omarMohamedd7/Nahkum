import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Judge/home/presentation/views/blog_details_view.dart';
import 'package:legal_app/app/features/Judge/home/presentation/widgets/custom_bottom_navigation_judge_Bar.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.notifications_none, color: Colors.grey[600]),
                  const Text(
                    'مراجع',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 24),

              // Search Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن كتاب أو مرجع...',
                    hintStyle: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ListView(
                  children: [
                    _buildBlogCard(
                      title: 'الموسوعة الجنائية العربية',
                      subtitle: 'عقوبات جنائية',
                      description:
                          'مرجع شامل ومتكامل يختص بشرح القوانين الجنائية العربية. يتناول الجرائم والعقوبات بتفصيل نظري وعملي.',
                    ),
                    _buildBlogCard(
                      title: 'قانون المرافعات المدنية والتجارية',
                      subtitle: 'قضايا مدنية وتجارية',
                      description:
                          'هذا الكتاب يُعدّ من الكتب الأساسية في الفقه القانوني، ويتناول الإجراءات التي تُتبع أمام المحاكم في القضايا المدنية.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationJudgeBar(
        key: ValueKey('home_view_bottom_nav'),
        currentIndex: 1,
      ),
    );
  }

  Widget _buildBlogCard({
    required String title,
    required String subtitle,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          Get.context!,
          MaterialPageRoute(builder: (_) => const BlogDetailsView()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppAssets.document,
                  color: AppColors.gold,
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: description.substring(
                      0,
                      description.length > 75 ? 75 : description.length,
                    ),
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (description.length > 75)
                    const TextSpan(
                      text: '... عرض المزيد',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 13,
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

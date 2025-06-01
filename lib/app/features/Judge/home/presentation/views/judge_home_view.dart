import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Judge/home/presentation/widgets/custom_bottom_navigation_judge_Bar.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/bottom_navigation_bar.dart';

class JudgeHomeView extends StatelessWidget {
  const JudgeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 43),
                _buildTopBar(),
                const SizedBox(height: 16),
                _buildWelcomeSection(context),
                const SizedBox(height: 16),
                _buildAIAssistCard(),
                const SizedBox(height: 24),
                _buildTasksHeader(),
                const SizedBox(height: 12),
                _buildTaskCard(
                  caseNumber: '453',
                  date: '2025/5/12',
                  day: 'الاثنين',
                  time: '8:30 am',
                  title: 'جلسة محكمة',
                  description:
                      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربي حيث ...',
                ),
                const SizedBox(height: 12),
                _buildTaskCard(
                  caseNumber: '460',
                  date: '2025/5/12',
                  day: 'الاثنين',
                  time: '10:00 am',
                  title: 'جلسة استماع',
                  description:
                      'وصف الجلسة سيكون هنا ويمكن تخصيصه حسب نوع القضية أو البيانات المتاحة ضمن النظام.',
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationJudgeBar(
        key: const ValueKey('home_view_bottom_nav'),
        currentIndex: 0,
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 18,
          child: Icon(Icons.notifications_none, color: Colors.white),
        ),
        Row(
          children: const [
            Text(
              'اسم المستخدم',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
              radius: 18,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth < 360 ? 22 : 24;
    final double textFontSize = screenWidth < 360 ? 13 : 14;
    final double logoWidth = screenWidth * 0.15;
    final double logoHeight = logoWidth * 1.24;

    return Container(
      width: double.infinity,
      height: screenWidth * 0.42, // Responsive height
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.05,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF181E3C).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'نحكم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: screenWidth * 0.025),
                Text(
                  'منصتك القانونية الموثوقة لربطك بمحامين مختصين وخدمات عدلية احترافية.',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: textFontSize,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.025),
          SvgPicture.asset(
            AppAssets.mainLogo,
            width: logoWidth,
            height: logoHeight,
            color: AppColors.goldLight,
          ),
        ],
      ),
    );
  }

  Widget _buildAIAssistCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'حلّ قضيتك بالذكاء الصناعي',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'قم برفع تسجيلات الفيديو الخاصة بالقضية ليتم معالجتها عبر تقنيات متقدمة لاكتشاف مؤشرات الكذب، ومساعدتك في اتخاذ قرارات أكثر عدلاً وموضوعية.',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.right,
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withOpacity(0.1),
            ),
            child: SvgPicture.asset(
              AppAssets.activeHome,
              width: 24,
              height: 24,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'عرض الكل',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        Text(
          'مهام اليوم',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard({
    required String caseNumber,
    required String date,
    required String day,
    required String time,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.keyboard_arrow_down_rounded, size: 22),
              Text(
                '#$caseNumber رقم القضية',
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.access_time,
                      size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 6),
                  Text(
                    '8:30 am',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.calendar_today,
                      size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 6),
                  Text(
                    'الاثنين - 2025/5/12',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}

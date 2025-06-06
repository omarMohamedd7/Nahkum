import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Judge/home/presentation/widgets/custom_bottom_navigation_judge_Bar.dart';

class AgenciesView extends StatelessWidget {
  const AgenciesView({super.key});

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
              const SizedBox(height: 56),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Color(0xffBFBFBF))),
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        AppAssets.unactiveSetting,
                      )),
                  const SizedBox(width: 11),
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Color(0xffBFBFBF))),
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        AppAssets.unactiveMessage,
                      )),
                  const SizedBox(width: 11),
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Color(0xffBFBFBF))),
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        AppAssets.notification,
                      )),
                  const SizedBox(width: 25),
                  Text(
                    'التوكيلات',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildAgencyCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationJudgeBar(
        currentIndex: 2,
      ),
    );
  }

  Widget _buildAgencyCard() {
    return Container(
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
                width: 24,
              ),
              const Text(
                'قضية أسرية',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'اسم الموكل: طارق الشعار',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
          const Text(
            'رقم القضية: #2500',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          const Text(
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'تفاصيل',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_back, size: 16, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

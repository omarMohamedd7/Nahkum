import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';

class SessionsScheduleView extends StatelessWidget {
  const SessionsScheduleView({super.key});

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
              _buildAppBar(),
              const SizedBox(height: 24),
              Expanded(child: _buildSessionList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.arrow_forward_ios, color: AppColors.primary),
        const Text(
          'جدول جلسات',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        SvgPicture.asset(AppAssets.verified, width: 20),
      ],
    );
  }

  Widget _buildSessionList() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildSessionCard();
      },
    );
  }

  Widget _buildSessionCard() {
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
          // العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(AppAssets.activeHome, width: 24, color: AppColors.gold),
              const Text(
                'قضية أسرية',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'رقم القضية: #2500',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'حالة القضية: نشطة',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 14, color: AppColors.primary),
                  SizedBox(width: 4),
                  Text(
                    'تفاصيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Text(
                    '2025/5/12 - الاثنين',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

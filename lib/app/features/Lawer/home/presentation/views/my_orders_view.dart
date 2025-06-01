import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Judge/home/presentation/widgets/custom_bottom_navigation_judge_Bar.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/controllers/my_orders_controller.dart';

class MyOrdersView extends StatelessWidget {
  MyOrdersView({super.key});
  final controller = Get.put(MyOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 56),
            _buildTopBar(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Color(0xffBFBFBF))),
                  height: 50,
                  child: Center(child: _buildToggleTabs())),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  return ListView(
                    children: [
                      controller.selectedIndex.value == 0
                          ? _buildRequestCard()
                          : _buildRequestCard(title: 'قضية استشارية'),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavigationJudgeBar(currentIndex: 0),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _iconWrapper(AppAssets.unactiveSetting),
              const SizedBox(width: 11),
              _iconWrapper(AppAssets.unactiveMessage),
              const SizedBox(width: 11),
              _iconWrapper(AppAssets.notification),
              const SizedBox(width: 25),
              const Text(
                'طلباتي',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _iconWrapper(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: const Color(0xffBFBFBF)),
      ),
      child: SvgPicture.asset(assetPath, width: 20, height: 20),
    );
  }

  Widget _buildToggleTabs() {
    return Obx(() {
      final index = controller.selectedIndex.value;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: index == 0 ? AppColors.gold : null,
                  ),
                  child: Text(
                    'طلبات التوكيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          index == 0 ? Colors.white : const Color(0xFFB8B8B8),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(1),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: index == 1 ? AppColors.gold : null,
                  ),
                  child: Text(
                    'طلبات الاستشارة',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          index == 1 ? Colors.white : const Color(0xFFB8B8B8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRequestCard({String title = 'قضية أسرية'}) {
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
              SvgPicture.asset(AppAssets.document,
                  color: AppColors.gold, width: 20),
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
          const Text(
            'اسم الموكل: طارق الشعار',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 4),
          const Text(
            'رقم القضية: #2500',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          const Text(
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربي حيث...',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.arrow_back_ios, size: 16, color: AppColors.primary),
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
        ],
      ),
    );
  }
}

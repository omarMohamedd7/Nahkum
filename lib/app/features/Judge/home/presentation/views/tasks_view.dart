import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Judge/home/presentation/views/add_task_view.dart';
import 'package:legal_app/app/features/Judge/home/presentation/widgets/custom_bottom_navigation_judge_Bar.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Top AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.notifications_none, color: Colors.grey[600]),
                  const Text(
                    'مهامي',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 24), // Spacer to balance icon
                ],
              ),
            ),
            const Spacer(),
            // Center Icon inside circle
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0E6),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.document,
                  width: 36,
                  height: 36,
                  color: AppColors.gold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'قائمة المهام فارغة!',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'ليس لديك أي مهام مجدولة في الوقت الحالي، قم بإضافة مهمة جديدة لتنظيم أعمالك والبقاء على اطلاع.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Add Task Button
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => AddTaskView());
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'إضافة مهمة جديدة',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavigationJudgeBar(currentIndex: 2),
    );
  }
}

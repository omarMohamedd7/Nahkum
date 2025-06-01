import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'مهامي',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey[600]),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'مهام اليوم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.gold,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.expand_more, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                    '#453 رقم قضية',
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                AppAssets.document,
                                width: 20,
                                height: 20,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                '8:30 am',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.access_time, size: 16),
                              SizedBox(width: 16),
                              Text(
                                '2025/5/12 - الاثنين',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.calendar_today, size: 16),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'جلسة محكمة',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربي حيث...',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Get.to(() => const AddTaskView()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          const CustomBottomNavigationJudgeBar(currentIndex: 2),
    );
  }
}

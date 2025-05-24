import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/modules/case_management/views/details%20case.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/theme/app_colors.dart';
import 'package:legal_app/app/global_widgets/custom_search_text_field.dart';
import '../controllers/case_management_controller.dart';
import '../widgets/case_card.dart';
import '../widgets/empty_state.dart';
import '../../../modules/home/widgets/bottom_navigation_bar.dart';
import '../models/case.dart' as case_management;

class CaseManagementView extends GetView<CaseManagementController> {
  const CaseManagementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.ScreenBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'قضاياي',
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: 'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Search Field
            CustomSearchTextField(
              controller: controller.searchController,
              hintText: 'ابحث برقم القضية...',
              onChanged: controller.onSearchChanged,
              showFilterButton: false,
            ),

            // Tab Navigation (only visible when not searching)
            Obx(() {
              return !controller.isSearching.value
                  ? TabBar(
                      controller: controller.tabController,
                      indicatorColor: const Color(0xFFC8A45D), // Gold color
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: 'بانتظار الموافقة'),
                        Tab(text: 'موافق عليها'),
                        Tab(text: 'مغلقة'),
                      ],
                    )
                  : const SizedBox();
            }),

            // Cases List or Empty State
            Expanded(
              child: Obx(() {
                final filteredCases = controller.getFilteredCases();

                if (filteredCases.isEmpty) {
                  return const Center(
                    child: Text('لا توجد قضايا'),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: filteredCases.length,
                    itemBuilder: (context, index) {
                      final caseItem = filteredCases[index];
                      return CaseCard(
                        caseItem: caseItem,
                        onTap: () => Get.to(() => CaseDetailsPage(
                              caseItem: case_management.Case(
                                id: caseItem.id,
                                title: caseItem.title,
                                description: caseItem.description,
                                caseNumber: caseItem.caseNumber,
                                caseType: caseItem.caseType,
                                status: caseItem.status,
                                createdAt: DateTime.now(),
                                assignedLawyerId: caseItem.lawyerId,
                                attachments: caseItem.attachments,
                              ),
                            )),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0, left: 16.0),
          child: FloatingActionButton(
            onPressed: controller.navigateToPublishCase,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

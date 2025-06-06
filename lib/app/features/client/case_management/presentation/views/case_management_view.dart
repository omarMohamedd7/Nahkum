import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/features/client/case_management/presentation/views/details%20case.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/shared/widgets/custom_search_text_field.dart';
import '../controllers/case_management_controller.dart';
import '../widgets/case_card.dart';
import '../widgets/case_offer_card.dart';
import '../../../home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:legal_app/app/core/data/models/case_model.dart' as CoreModel;
import '../../data/models/case_model.dart' as FeatureModel;
import '../../data/models/case_offer.dart';
import '../../data/models/case.dart' as DetailCase;

class CaseManagementView extends GetView<CaseManagementController> {
  const CaseManagementView({Key? key}) : super(key: key);

  // Convert from core CaseModel to feature CaseModel
  FeatureModel.CaseModel _convertCaseModel(CoreModel.CaseModel coreModel) {
    return FeatureModel.CaseModel(
      id: coreModel.id,
      title: coreModel.title,
      description: coreModel.description,
      caseNumber: coreModel.caseNumber,
      caseType: coreModel.caseType,
      status: coreModel.status,
      createdAt: DateTime.now(),
      assignedLawyerId: coreModel.assignedLawyerId,
      attachments: coreModel.attachments,
    );
  }

  @override
  Widget build(BuildContext context) {
    // First, set Directionality for RTL content
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
                        Tab(text: 'الطلبات الواردة'),
                      ],
                    )
                  : const SizedBox();
            }),

            // Items List (Cases or Offers)
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                final items = controller.getFilteredItems();

                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا توجد عناصر',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontFamily: 'Almarai',
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      // Check if we're in the offers tab
                      if (controller.currentTabIndex.value == 3) {
                        final offer = item as CaseOffer;
                        return CaseOfferCard(
                          offer: offer,
                          onTap: () => controller.navigateToOfferDetails(offer),
                        );
                      } else {
                        // Regular case
                        final coreCaseItem = item as CoreModel.CaseModel;
                        final featureCaseItem = _convertCaseModel(coreCaseItem);

                        return CaseCard(
                          caseItem: featureCaseItem,
                          onTap: () {
                            // Convert from core Case to detail Case
                            final detailCase = DetailCase.Case(
                              id: coreCaseItem.id,
                              title: coreCaseItem.title,
                              description: coreCaseItem.description,
                              caseNumber: coreCaseItem.caseNumber,
                              caseType: coreCaseItem.caseType,
                              status: coreCaseItem.status,
                              createdAt: DateTime.now(),
                              assignedLawyerId: coreCaseItem.assignedLawyerId,
                              attachments: coreCaseItem.attachments,
                            );
                            Get.to(() => CaseDetailsPage(caseItem: detailCase));
                          },
                        );
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
        // Use a builder for the bottom navigation bar to isolate it from RTL context
        bottomNavigationBar: Builder(
          builder: (context) => Directionality(
            textDirection: TextDirection.ltr,
            child: const CustomBottomNavigationBar(currentIndex: 3),
          ),
        ),
      ),
    );
  }
}

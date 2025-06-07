import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/case_item.dart';
import '../../../../../routes/app_routes.dart';

class CasesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Tab controller for active and closed cases
  late TabController tabController;

  // Reactive variables for UI state
  final RxList<CaseItem> activeCases = <CaseItem>[].obs;
  final RxList<CaseItem> closedCases = <CaseItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // Set initial tab to Active Cases (index 1)
    tabController.index = 1;

    fetchCases();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // Fetch cases from repository or API
  Future<void> fetchCases() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - would be replaced with actual API call
      final mockActiveCases = [
        CaseItem(
          caseId: 1,
          caseType: 'قضية أسرية',
          clientName: 'طارق الشعار',
          caseNumber: '#2500',
          status: 'نشطة',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
        ),
        CaseItem(
          caseId: 2,
          caseType: 'قضية تجارية',
          clientName: 'عبدالله محمد',
          caseNumber: '#2501',
          status: 'نشطة',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
        ),
        CaseItem(
          caseId: 3,
          caseType: 'قضية جنائية',
          clientName: 'محمد علي',
          caseNumber: '#2502',
          status: 'نشطة',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
        ),
      ];

      final mockClosedCases = [
        CaseItem(
          caseId: 4,
          caseType: 'قضية أسرية',
          clientName: 'محمد العلي',
          caseNumber: '#2345',
          status: 'مغلقة',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
        ),
        CaseItem(
          caseId: 5,
          caseType: 'قضية إدارية',
          clientName: 'سارة احمد',
          caseNumber: '#2346',
          status: 'مغلقة',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
        ),
      ];

      activeCases.assignAll(mockActiveCases);
      closedCases.assignAll(mockClosedCases);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ أثناء تحميل القضايا';
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to case details
  void navigateToCaseDetails(int caseId) {
    // Use a proper case details route with arguments
    Get.toNamed(Routes.CASE_DETAILS, arguments: {
      'caseId': caseId,
      'fromScreen': 'lawyer_cases',
    });
  }

  // Refresh cases data
  Future<void> refreshCases() async {
    await fetchCases();
  }
}

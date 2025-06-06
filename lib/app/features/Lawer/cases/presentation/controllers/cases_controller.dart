import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cases/data/models/case_model.dart';
import '../../../../../routes/app_routes.dart';

class CasesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Tab controller for active and closed cases
  late TabController tabController;

  // Reactive variables for UI state
  final RxList<CaseModel> activeCases = <CaseModel>[].obs;
  final RxList<CaseModel> closedCases = <CaseModel>[].obs;
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
        CaseModel(
          id: '1',
          title: 'قضية أسرية',
          clientName: 'طارق الشعار',
          caseNumber: '#2500',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
          status: CaseStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        CaseModel(
          id: '2',
          title: 'قضية أسرية',
          clientName: 'طارق الشعار',
          caseNumber: '#2500',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
          status: CaseStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
        CaseModel(
          id: '3',
          title: 'قضية أسرية',
          clientName: 'طارق الشعار',
          caseNumber: '#2500',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
          status: CaseStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];

      final mockClosedCases = [
        CaseModel(
          id: '4',
          title: 'قضية أسرية',
          clientName: 'محمد العلي',
          caseNumber: '#2345',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
          status: CaseStatus.closed,
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
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
  void navigateToCaseDetails(String caseId) {
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

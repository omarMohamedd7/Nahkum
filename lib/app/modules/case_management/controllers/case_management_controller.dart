import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/data/models/case.dart';
import 'package:legal_app/app/routes/app_routes.dart';

class CaseManagementController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Tab controller
  late TabController tabController;

  // Text controller for search
  final searchController = TextEditingController();

  // Observable variables
  final RxList<Case> waitingApprovalCases = <Case>[].obs;
  final RxList<Case> approvedCases = <Case>[].obs;
  final RxList<Case> closedCases = <Case>[].obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;
  final RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentTabIndex.value = tabController.index;
      }
    });

    fetchCases();
  }

  @override
  void onClose() {
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void fetchCases() {
    // Mock data for cases with different statuses
    waitingApprovalCases.value = [
      Case(
          id: '1',
          title: 'طلب استشارة قانونية حول عقد إيجار',
          description:
              'أرغب في الحصول على استشارة قانونية بشأن عقد إيجار تجاري مع شروط غير واضحة',
          caseNumber: '2023-156',
          caseType: 'استشارة قانونية',
          status: 'بانتظار الموافقة',
          lawyerId: 'محمد أحمد',
          attachments: []),
      Case(
          id: '2',
          title: 'طلب مراجعة عقد عمل',
          description:
              'أحتاج إلى مراجعة عقد العمل الخاص بي قبل التوقيع عليه للتأكد من عدم وجود بنود مجحفة',
          caseNumber: '2023-157',
          caseType: 'قانون العمل',
          status: 'بانتظار الموافقة',
          lawyerId: 'محمد أحمد',
          attachments: []),
    ];

    approvedCases.value = [
      Case(
          id: '3',
          title: 'دعوى مطالبة مالية',
          description: 'دعوى للمطالبة بمستحقات مالية متأخرة من شركة سابقة',
          caseNumber: '2023-120',
          caseType: 'قضايا مدنية',
          status: 'موافق عليه',
          lawyerId: ' أحمد',
          attachments: []),
    ];

    closedCases.value = [
      Case(
          id: '4',
          title: 'استشارة قانونية حول قضية إرث',
          description:
              'تم تقديم استشارة قانونية حول كيفية توزيع الإرث وفقاً للقانون',
          caseNumber: '2023-098',
          caseType: 'أحوال شخصية',
          status: 'مغلق',
          lawyerId: 'خالد محمود',
          attachments: []),
    ];
  }

  List<Case> getFilteredCases() {
    if (searchQuery.isEmpty) {
      // If no search query, return cases based on current tab
      switch (currentTabIndex.value) {
        case 0:
          return waitingApprovalCases;
        case 1:
          return approvedCases;
        case 2:
          return closedCases;
        default:
          return waitingApprovalCases;
      }
    } else {
      // If searching, filter by case number across all cases
      final allCases = [
        ...waitingApprovalCases,
        ...approvedCases,
        ...closedCases,
      ];

      return allCases
          .where((caseItem) =>
              caseItem.caseNumber.contains(searchQuery.value) ||
              caseItem.title.contains(searchQuery.value))
          .toList();
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;
  }

  void onClearSearch() {
    searchController.clear();
    searchQuery.value = '';
    isSearching.value = false;
  }

  void navigateToPublishCase() {
    Get.toNamed(Routes.PUBLISH_CASE);
  }

  void navigateToCaseDetails(Case caseItem) {
    Get.toNamed(Routes.CASE_DETAILS, arguments: caseItem);
  }
}

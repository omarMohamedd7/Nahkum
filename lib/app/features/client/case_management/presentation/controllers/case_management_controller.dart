import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/data/models/case.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import '../../data/models/case_offer.dart';

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
  final RxList<CaseOffer> caseOffers = <CaseOffer>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;
  final RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_handleTabSelection);

    fetchCases();
    fetchCaseOffers();
  }

  @override
  void onClose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void _handleTabSelection() {
    if (!tabController.indexIsChanging) {
      currentTabIndex.value = tabController.index;
    }
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

  void fetchCaseOffers() {
    isLoading.value = true;

    try {
      // Mock data for offers
      caseOffers.value = [
        CaseOffer(
          id: '1',
          caseNumber: '3345',
          caseType: 'قضية جنائية',
          lawyerId: 'lawyer1',
          lawyerName: 'أسم المحامي',
          description: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة.',
          price: 500.0,
          status: 'pending',
          createdAt: DateTime.now(),
        ),
        CaseOffer(
          id: '2',
          caseNumber: '3346',
          caseType: 'قضية مدنية',
          lawyerId: 'lawyer2',
          lawyerName: 'أسم المحامي',
          description: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة.',
          price: 750.0,
          status: 'pending',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
    } catch (e) {
      print('Error loading offers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<dynamic> getFilteredItems() {
    if (searchQuery.isNotEmpty) {
      // If searching, filter by case number across all cases and offers
      final allCases = [
        ...waitingApprovalCases,
        ...approvedCases,
        ...closedCases,
      ];

      if (currentTabIndex.value == 3) {
        // Search in offers
        return caseOffers
            .where((offer) =>
                offer.caseNumber.contains(searchQuery.value) ||
                offer.caseType.contains(searchQuery.value))
            .toList();
      } else {
        // Search in cases
        return allCases
            .where((caseItem) =>
                caseItem.caseNumber.contains(searchQuery.value) ||
                caseItem.title.contains(searchQuery.value))
            .toList();
      }
    }

    // If no search query, return items based on current tab
    switch (currentTabIndex.value) {
      case 0:
        return waitingApprovalCases;
      case 1:
        return approvedCases;
      case 2:
        return closedCases;
      case 3:
        return caseOffers;
      default:
        return waitingApprovalCases;
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

  void navigateToOfferDetails(CaseOffer offer) {
    Get.toNamed(
      Routes.CASE_OFFER_DETAIL,
      arguments: {
        'offer': offer,
      },
    );
  }

  void acceptOffer(CaseOffer offer) async {
    isLoading.value = true;

    try {
      // In a real app, this would be an API call to accept the offer
      await Future.delayed(const Duration(seconds: 1));

      // Remove from offers list
      caseOffers.removeWhere((item) => item.id == offer.id);

      // Add to approved cases
      approvedCases.add(
        Case(
          id: offer.id,
          title: offer.caseType,
          description: offer.description,
          caseNumber: offer.caseNumber,
          caseType: offer.caseType,
          status: 'موافق عليه',
          lawyerId: offer.lawyerId,
          attachments: [],
        ),
      );

      // Navigate to chat with lawyer
      Get.toNamed(Routes.CHAT_DETAIL, arguments: {
        'lawyerId': offer.lawyerId,
        'lawyerName': offer.lawyerName,
      });
    } catch (e) {
      print('Error accepting offer: $e');
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء قبول العرض',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

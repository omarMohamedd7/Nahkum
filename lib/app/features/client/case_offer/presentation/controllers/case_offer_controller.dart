import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/case_offer.dart';
import '../../../../../routes/app_routes.dart';

class CaseOfferController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final isLoading = false.obs;
  final searchController = TextEditingController();
  final isSearching = false.obs;

  late TabController tabController;
  final selectedTabIndex = 0.obs;

  // Mock data for offers
  final allOffers = <CaseOffer>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });

    _loadOffers();

    searchController.addListener(() {
      isSearching.value = searchController.text.isNotEmpty;
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    tabController.dispose();
    super.onClose();
  }

  void _loadOffers() {
    isLoading.value = true;

    try {
      // In a real app, this would be an API call
      // For now, we'll use mock data
      final mockOffers = [
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
          caseType: 'قضية جنائية',
          lawyerId: 'lawyer2',
          lawyerName: 'أسم المحامي',
          description: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة.',
          price: 750.0,
          status: 'accepted',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        CaseOffer(
          id: '3',
          caseNumber: '3347',
          caseType: 'قضية جنائية',
          lawyerId: 'lawyer3',
          lawyerName: 'أسم المحامي',
          description: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة.',
          price: 600.0,
          status: 'closed',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

      allOffers.assignAll(mockOffers);
    } catch (e) {
      print('Error loading offers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<CaseOffer> getFilteredOffers() {
    if (isSearching.value) {
      final searchQuery = searchController.text.toLowerCase();
      return allOffers
          .where((offer) =>
              offer.caseNumber.toLowerCase().contains(searchQuery) ||
              offer.caseType.toLowerCase().contains(searchQuery))
          .toList();
    }

    // Filter based on selected tab
    switch (selectedTabIndex.value) {
      case 0: // بانتظار الموافقة
        return allOffers.where((offer) => offer.status == 'pending').toList();
      case 1: // موافق عليها (فعالة)
        return allOffers.where((offer) => offer.status == 'accepted').toList();
      case 2: // مغلقة
        return allOffers.where((offer) => offer.status == 'closed').toList();
      case 3: // الطلبات الواردة
        return allOffers; // In a real app, this would be filtered differently
      default:
        return allOffers;
    }
  }

  void onSearchChanged(String query) {
    // This method is called when the search text changes
    // The isSearching value is already updated by the listener
  }

  void navigateToOfferDetails(CaseOffer offer) {
    // Navigate to the offer details page
    Get.toNamed(
      Routes.CASE_OFFER_DETAIL,
      arguments: {
        'offer': offer,
      },
    );
  }
}

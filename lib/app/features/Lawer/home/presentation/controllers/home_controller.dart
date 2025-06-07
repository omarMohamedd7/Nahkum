import 'package:get/get.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/attorney_request_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/published_case_model.dart';
import 'package:legal_app/app/routes/app_routes.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;

  // Attorney requests using the model
  final RxList<AttorneyRequestModel> attorneyRequests =
      <AttorneyRequestModel>[].obs;

  // Published cases using the model
  final RxList<PublishedCaseModel> publishedCases = <PublishedCaseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
    // In a real app, you would call these methods instead:
    // fetchAttorneyRequests();
    // fetchPublishedCases();
  }

  // Method to fetch attorney requests from repository
  Future<void> fetchAttorneyRequests() async {
    try {
      isLoading(true);
      // This would be replaced with actual API call
      // final response = await attorneyRequestRepository.getAttorneyRequests();
      // attorneyRequests.value = response.map((data) => AttorneyRequestModel.fromJson(data)).toList();
    } catch (e) {
      // Handle error
      print('Error fetching attorney requests: $e');
    } finally {
      isLoading(false);
    }
  }

  // Method to fetch published cases from repository
  Future<void> fetchPublishedCases() async {
    try {
      isLoading(true);
      // This would be replaced with actual API call
      // final response = await publishCaseRepository.getPublishedCases();
      // final List<PublishCaseModel> publishedCasesData = response.map((data) => PublishCaseModel.fromJson(data)).toList();

      // Convert PublishCaseModel to PublishedCaseModel
      // publishedCases.value = publishedCasesData.map((publishCase) {
      //   return PublishedCaseModel.fromPublishCase(publishCase);
      // }).toList();
    } catch (e) {
      // Handle error
      print('Error fetching published cases: $e');
    } finally {
      isLoading(false);
    }
  }

  void _loadMockData() {
    // Load mock attorney requests data
    attorneyRequests.addAll([
      AttorneyRequestModel(
        id: '1',
        caseType: 'قضية أسرية',
        clientName: 'طارق الشعار',
        caseStatus: 'بانتظار الموافقة',
        caseNumber: '#2500',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
      ),
      AttorneyRequestModel(
        id: '2',
        caseType: 'قضية أسرية',
        clientName: 'طارق الشعار',
        caseStatus: 'بانتظار الموافقة',
        caseNumber: '#2500',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
      ),
    ]);

    // Load mock published cases data
    publishedCases.addAll([
      PublishedCaseModel(
        id: '1',
        caseType: 'قضية أسرية',
        clientName: 'طارق الشعار',
        city: 'الرياض',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
      ),
      PublishedCaseModel(
        id: '2',
        caseType: 'قضية أسرية',
        clientName: 'طارق الشعار',
        city: 'جدة',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث...',
      ),
    ]);
  }

  void navigateToAttorneyRequestDetails(AttorneyRequestModel request) {
    // Navigate to attorney request details page
    Get.toNamed('/lawyer/attorney-request-details',
        arguments: request.toJson());
  }

  void navigateToPublishedCaseDetails(PublishedCaseModel caseData) {
    // Navigate to submit offer page
    Get.toNamed(Routes.LAWYER_SUBMIT_OFFER, arguments: {
      'caseType': caseData.caseType,
      'city': caseData.city ?? '',
      'caseId': caseData.id,
    });
  }

  void navigateToAllAttorneyRequests() {
    // Navigate to طلباتي page (My Orders)
    print("Navigating to My Orders page");
    Get.offAllNamed(Routes.LAWYER_ORDERS);
  }

  void navigateToAllPublishedCases() {
    // Navigate to التوكيلات page (Agencies)
    print("Navigating to Agencies page");
    Get.offAllNamed(Routes.LAWYER_AGENCIES);
  }
}

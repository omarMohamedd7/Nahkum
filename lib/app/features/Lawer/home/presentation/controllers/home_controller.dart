import 'package:get/get.dart';
import 'package:legal_app/app/core/data/models/case_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/attorney_request_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/published_case_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/session_model.dart';
import 'package:legal_app/app/features/client/publish_case/data/models/publish_case_model.dart';
import 'package:legal_app/app/routes/app_routes.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;

  // Sessions using the model
  final RxList<LawyerSessionModel> sessions = <LawyerSessionModel>[].obs;

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
    // fetchLawyerSessions();
    // fetchAttorneyRequests();
    // fetchPublishedCases();
  }

  // Method to fetch lawyer sessions from repository
  Future<void> fetchLawyerSessions() async {
    try {
      isLoading(true);
      // This would be replaced with actual API call
      // final response = await lawyerSessionRepository.getLawyerSessions();
      // final List<CaseModel> casesData = response.map((data) => CaseModel.fromJson(data)).toList();

      // Convert CaseModel to LawyerSessionModel
      // sessions.value = casesData.map((caseData) {
      //   return LawyerSessionModel.fromCaseModel(
      //     caseData,
      //     date: 'الأثنين, 2025/5/12', // This would come from a session date field
      //   );
      // }).toList();
    } catch (e) {
      // Handle error
      print('Error fetching lawyer sessions: $e');
    } finally {
      isLoading(false);
    }
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
    // Load mock sessions data
    sessions.addAll([
      LawyerSessionModel(
        id: '1',
        caseType: 'قضية أسرية',
        clientName: 'طارق الشعار',
        caseStatus: 'نشطة',
        caseNumber: '#4300',
        date: 'الأثنين, 2025/5/12',
      ),
      LawyerSessionModel(
        id: '2',
        caseType: 'قضية أسرية',
        clientName: 'طارق الشعار',
        caseStatus: 'نشطة',
        caseNumber: '#4300',
        date: 'الأثنين, 2025/5/12',
      ),
    ]);

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

  void navigateToSessionDetails(LawyerSessionModel session) {
    // Navigate to session details page
    Get.toNamed('/lawyer/session-details', arguments: session.toJson());
  }

  void navigateToAttorneyRequestDetails(AttorneyRequestModel request) {
    // Navigate to attorney request details page
    Get.toNamed('/lawyer/attorney-request-details',
        arguments: request.toJson());
  }

  void navigateToPublishedCaseDetails(PublishedCaseModel caseData) {
    // Navigate to published case details page
    Get.toNamed('/lawyer/published-case-details', arguments: caseData.toJson());
  }

  void navigateToAllSessions() {
    // Navigate to all sessions page
    Get.toNamed(Routes.LAWYER_SESSIONS);
  }

  void navigateToAllAttorneyRequests() {
    // Navigate to all attorney requests page
    Get.toNamed('/lawyer/attorney-requests');
  }

  void navigateToAllPublishedCases() {
    // Navigate to all published cases page
    Get.toNamed('/lawyer/published-cases');
  }
}

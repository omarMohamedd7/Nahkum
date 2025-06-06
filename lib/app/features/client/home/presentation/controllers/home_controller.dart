import 'package:get/get.dart';
import '../../../../../core/data/models/lawyer.dart';

class HomeController extends GetxController {
  // Observable state variables with reactive (.obs) properties
  var isLoading = false.obs;
  var lawyers = <Lawyer>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initial data loading
    fetchLawyers();
  }

  @override
  void onReady() {
    super.onReady();
    // Called after onInit when the widget is rendered on screen
  }

  @override
  void onClose() {
    // Clean up resources if necessary
    super.onClose();
  }

  // Fetch lawyers data
  void fetchLawyers() {
    isLoading.value = true;

    try {
      // Simulating API call with dummy data
      // In a real app, you would use ApiService to get data
      final dummyLawyers = [
        Lawyer(
          id: '1',
          name: 'أسم المحامي',
          location: 'دمشق',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد',
          price: 20.5,
          imageUrl: 'assets/images/user-profile-image.svg',
          specialization: 'قانون مدني',
        ),
        Lawyer(
          id: '2',
          name: 'أسم المحامي',
          location: 'دمشق',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد',
          price: 20.5,
          imageUrl: 'https://randomuser.me/api/portraits/men/43.jpg',
          specialization: 'قانون جنائي',
        ),
      ];

      lawyers.assignAll(dummyLawyers);
    } catch (e) {
      // Handle error
      print('Error fetching lawyers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation methods can be moved from UI to controller
  void navigateToPublishCase() {
    Get.toNamed('/publish_case');
  }

  void navigateToLawyersListing() {
    Get.toNamed('/lawyers_listing');
  }

  void navigateToConsultationRequest(Lawyer lawyer) {
    Get.toNamed('/consultation_request', arguments: lawyer);
  }
}

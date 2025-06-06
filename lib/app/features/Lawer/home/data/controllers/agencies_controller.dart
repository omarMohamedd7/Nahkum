import 'package:get/get.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/agency_model.dart';

class AgenciesController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<AgencyModel> agencies = <AgencyModel>[].obs;
  final Rx<String?> errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAgencies();
  }

  Future<void> fetchAgencies() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call with dummy data
      await Future.delayed(const Duration(seconds: 1));

      final agencyList = [
        const AgencyModel(
          id: '1',
          caseType: 'قضية أسرية',
          clientName: 'طارق الشعار',
          caseNumber: '#2500',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
        ),
        const AgencyModel(
          id: '2',
          caseType: 'قضية جنائية',
          clientName: 'أحمد محمد',
          caseNumber: '#2501',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
        ),
        const AgencyModel(
          id: '3',
          caseType: 'قضية مدنية',
          clientName: 'سارة خالد',
          caseNumber: '#2502',
          description:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
        ),
      ];

      agencies.assignAll(agencyList);
      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'حدث خطأ أثناء تحميل التوكيلات';
      isLoading.value = false;
    }
  }
}

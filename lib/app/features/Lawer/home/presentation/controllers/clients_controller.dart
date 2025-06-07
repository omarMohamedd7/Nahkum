import 'package:get/get.dart';
import '../../data/models/client.dart';
import '../../data/models/case_item.dart';

class ClientsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<Client> clients = <Client>[].obs;
  final RxList<CaseItem> cases = <CaseItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchClients();
  }

  void fetchClients() async {
    try {
      isLoading.value = true;
      // Simulating API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data for clients
      final List<Client> mockClients = [
        Client(
          id: 1,
          name: 'أحمد محمد',
          phoneNumber: '0123456789',
          city: 'القاهرة',
          profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        ),
        Client(
          id: 2,
          name: 'سارة أحمد',
          phoneNumber: '0123456788',
          city: 'الإسكندرية',
          profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
        ),
        Client(
          id: 3,
          name: 'محمود علي',
          phoneNumber: '0123456787',
          city: 'الجيزة',
          profileImageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
        ),
        Client(
          id: 4,
          name: 'فاطمة حسن',
          phoneNumber: '0123456786',
          city: 'الإسماعيلية',
          profileImageUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
        ),
        Client(
          id: 5,
          name: 'عمر خالد',
          phoneNumber: '0123456785',
          city: 'بورسعيد',
          profileImageUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
        ),
      ];

      // Mock data for client models (to be displayed in the UI)
      final List<Client> fetchedClients = [
        Client(
          id: 1,
          name: 'أحمد محمد',
          phoneNumber: '0123456789',
          city: 'القاهرة',
          profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        ),
        Client(
          id: 2,
          name: 'سارة أحمد',
          phoneNumber: '0123456788',
          city: 'الإسكندرية',
          profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
        ),
      ];

      // Create case models based on clients
      final List<CaseItem> mockCases = mockClients.map((client) {
        return CaseItem(
          caseId: client.id,
          caseType: getCaseTypeForClient(client.id),
          clientName: client.name,
          caseNumber: 'CASE-${1000 + client.id}',
          status: 'جاري النظر',
          description: 'وصف تفصيلي للقضية رقم ${client.id}',
        );
      }).toList();

      clients.assignAll(fetchedClients);
      cases.assignAll(mockCases);
      hasError.value = false;
      errorMessage.value = '';
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ أثناء تحميل بيانات الموكلين';
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToClientDetails(int clientId) {
    // Navigate to client details page
    // Get.toNamed('/client-details/$clientId');
  }

  String getCaseTypeForClient(int clientId) {
    switch (clientId) {
      case 1:
        return 'قضية مدنية';
      case 2:
        return 'قضية جنائية';
      case 3:
        return 'قضية تجارية';
      case 4:
        return 'قضية أحوال شخصية';
      case 5:
        return 'قضية إدارية';
      default:
        return 'قضية أخرى';
    }
  }
}

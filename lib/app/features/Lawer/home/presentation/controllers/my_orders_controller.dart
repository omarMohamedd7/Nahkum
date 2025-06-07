import 'package:get/get.dart';
import '../../data/models/order_model.dart';
import '../../data/models/client.dart';
import '../../data/models/case_item.dart';

class MyOrdersController extends GetxController {
  final selectedIndex = 0.obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  // Lists for different request types
  final caseRequests = <OrderModel>[].obs;
  final consultationRequests = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      // Mock data - replace with actual API call
      await Future.delayed(Duration(seconds: 1));
      _setMockData();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = 'حدث خطأ أثناء تحميل البيانات';
      print('Error fetching orders: $e');
    }
  }

  void _setMockData() {
    // Mock case requests
    caseRequests.value = [
      OrderModel(
        requestId: 1,
        status: 'pending',
        createdAt: '2023-10-15T10:30:00Z',
        caseData: CaseItem(
          caseId: 101,
          caseNumber: 'C2023-101',
          caseType: 'قضية جنائية',
          clientName: 'أحمد محمد',
          description: 'قضية تتعلق بنزاع على ملكية أرض في منطقة الرياض',
          status: 'جاري النظر',
        ),
        clientData: Client(
          id: 501,
          name: 'محمد علي',
          phoneNumber: '05xxxxxxxx',
          city: 'الرياض',
          profileImageUrl: '',
        ),
      ),
      OrderModel(
        requestId: 2,
        status: 'accepted',
        createdAt: '2023-10-10T08:15:00Z',
        caseData: CaseItem(
          caseId: 102,
          caseNumber: 'C2023-102',
          caseType: 'قضية مدنية',
          clientName: 'خالد ابراهيم',
          description: 'نزاع حول عقد إيجار في جدة',
          status: 'مقبولة',
        ),
        clientData: Client(
          id: 502,
          name: 'فهد العتيبي',
          phoneNumber: '05xxxxxxxx',
          city: 'جدة',
          profileImageUrl: '',
        ),
      ),
      OrderModel(
        requestId: 3,
        status: 'rejected',
        createdAt: '2023-10-05T14:45:00Z',
        caseData: CaseItem(
          caseId: 103,
          caseNumber: 'C2023-103',
          caseType: 'قضية تجارية',
          clientName: 'سعد القحطاني',
          description: 'نزاع تجاري حول مبلغ مالي متعلق بصفقة تجارية',
          status: 'مرفوضة',
        ),
        clientData: Client(
          id: 503,
          name: 'عبدالله الحربي',
          phoneNumber: '05xxxxxxxx',
          city: 'الدمام',
          profileImageUrl: '',
        ),
      ),
    ];

    // Mock consultation requests
    consultationRequests.value = [
      OrderModel(
        requestId: 4,
        status: 'pending',
        createdAt: '2023-10-14T09:20:00Z',
        caseData: CaseItem(
          caseId: 104,
          caseNumber: 'CNS-2023-001',
          caseType: 'استشارة قانونية',
          clientName: '',
          description: 'استشارة حول إجراءات إنشاء شركة جديدة',
          status: 'قيد الانتظار',
        ),
        clientData: Client(
          id: 504,
          name: 'ناصر السالم',
          phoneNumber: '05xxxxxxxx',
          city: 'الرياض',
          profileImageUrl: '',
        ),
      ),
      OrderModel(
        requestId: 5,
        status: 'accepted',
        createdAt: '2023-10-12T11:30:00Z',
        caseData: CaseItem(
          caseId: 105,
          caseNumber: 'CNS-2023-002',
          caseType: 'استشارة عقارية',
          clientName: '',
          description: 'استشارة قانونية متعلقة بعقد بيع عقاري',
          status: 'مقبولة',
        ),
        clientData: Client(
          id: 505,
          name: 'سلطان الشمري',
          phoneNumber: '05xxxxxxxx',
          city: 'الرياض',
          profileImageUrl: '',
        ),
      ),
    ];
  }

  void navigateToOrderDetails(int requestId) {
    // Navigate to order details page
    print('Navigating to order details: $requestId');
    // Get.toNamed(Routes.ORDER_DETAILS, arguments: {'requestId': requestId});
  }
}

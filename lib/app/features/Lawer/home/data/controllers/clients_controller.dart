import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/client_model.dart';
import '../../../../../routes/app_routes.dart';

class ClientsController extends GetxController {
  // Reactive variables for UI state
  final RxList<ClientModel> clients = <ClientModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClients();
  }

  // Fetch clients from repository or API
  Future<void> fetchClients() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - would be replaced with actual API call
      final mockClients = [
        ClientModel(
          id: '1',
          name: 'أسم الموكل',
          caseType: 'قضية أسرية',
          caseNumber: '#2500',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        ClientModel(
          id: '2',
          name: 'أسم الموكل',
          caseType: 'قضية أسرية',
          caseNumber: '#2500',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
        ClientModel(
          id: '3',
          name: 'أسم الموكل',
          caseType: 'قضية أسرية',
          caseNumber: '#2500',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        ClientModel(
          id: '4',
          name: 'أسم الموكل',
          caseType: 'قضية أسرية',
          caseNumber: '#2500',
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
        ),
        ClientModel(
          id: '5',
          name: 'أسم الموكل',
          caseType: 'قضية أسرية',
          caseNumber: '#2500',
          createdAt: DateTime.now().subtract(const Duration(days: 90)),
        ),
      ];

      clients.assignAll(mockClients);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ أثناء تحميل الموكلين';
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to client details
  void navigateToClientDetails(String clientId) {
    // For now, just show a snackbar since client details page doesn't exist yet
    Get.snackbar(
      'تفاصيل الموكل',
      'سيتم عرض تفاصيل الموكل قريباً',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFC8A45D),
      colorText: Colors.white,
    );
  }

  // Refresh clients data
  Future<void> refreshClients() async {
    await fetchClients();
  }
}

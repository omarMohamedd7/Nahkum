import 'package:get/get.dart';

class AgenciesController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAgencies();
  }

  Future<void> fetchAgencies() async {
    try {
      isLoading.value = true;
      // This would be replaced with actual API call
      await Future.delayed(const Duration(seconds: 1));
      // Fetch agencies data
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ أثناء تحميل البيانات';
      print('Error fetching agencies: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

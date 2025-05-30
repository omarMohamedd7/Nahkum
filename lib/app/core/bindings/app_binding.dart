import 'package:get/get.dart';
import '../data/services/api_service.dart';
import '../data/services/storage_service.dart';
import '../controllers/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize core services
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<StorageService>(() => StorageService(), fenix: true);

    // Initialize core controllers
    Get.lazyPut<AppController>(() => AppController(), fenix: true);

    // You can add more global dependencies here
  }
}

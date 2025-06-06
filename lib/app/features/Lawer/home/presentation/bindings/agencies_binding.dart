import 'package:get/get.dart';
import 'package:legal_app/app/features/Lawer/home/data/controllers/agencies_controller.dart';

class AgenciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgenciesController>(() => AgenciesController());
  }
}

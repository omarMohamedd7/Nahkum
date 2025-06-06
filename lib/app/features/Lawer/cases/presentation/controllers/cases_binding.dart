import 'package:get/get.dart';
import 'cases_controller.dart';

class CasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CasesController>(
      () => CasesController(),
    );
  }
}

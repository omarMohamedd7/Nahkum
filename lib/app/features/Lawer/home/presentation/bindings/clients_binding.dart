import 'package:get/get.dart';
import 'package:legal_app/app/features/Lawer/home/data/controllers/clients_controller.dart';

class ClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientsController>(
      () => ClientsController(),
    );
  }
}

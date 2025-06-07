import 'package:get/get.dart';
import '../controllers/submit_offer_controller.dart';

class SubmitOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitOfferController>(
      () => SubmitOfferController(),
    );
  }
}

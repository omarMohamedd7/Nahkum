import 'package:get/get.dart';
import 'package:legal_app/app/features/client/home/data/models/lawyer_model.dart';
import '../../data/models/case_offer.dart';
import '../../../../../routes/app_routes.dart';

class CaseOfferDetailController extends GetxController {
  final isLoading = false.obs;
  final offer = Rx<CaseOffer?>(null);
  final lawyer = Rx<Lawyer?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadOfferDetails();
  }

  void _loadOfferDetails() {
    try {
      isLoading.value = true;

      // Get arguments passed from the previous screen
      final Map<String, dynamic> arguments = Get.arguments ?? {};

      if (arguments.containsKey('offer')) {
        offer.value = arguments['offer'] as CaseOffer;
      }

      if (arguments.containsKey('lawyer')) {
        lawyer.value = arguments['lawyer'] as Lawyer;
      } else if (offer.value != null) {
        // In a real app, you would fetch the lawyer details using the lawyerId
        // For now, we'll create a mock lawyer
        _fetchLawyerDetails(offer.value!.lawyerId);
      }
    } catch (e) {
      print('Error loading offer details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchLawyerDetails(String lawyerId) async {
    // In a real app, this would be an API call
    // For now, we'll return mock data
    lawyer.value = Lawyer(
      id: lawyerId,
      description: 'محامي جنائي',
      price: 1000,
      name: 'أسم المحامي',
      specialization: 'محامي جنائي',
      city: 'الرياض',
      imageUrl: 'assets/images/lawyer_profile.png',
    );
  }

  Future<void> acceptOffer() async {
    if (offer.value == null) return;

    isLoading.value = true;

    try {
      // In a real app, this would be an API call to accept the offer
      await Future.delayed(const Duration(seconds: 1));

      // Show success message
      Get.snackbar(
        'تم',
        'تم قبول العرض بنجاح',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to chat with lawyer
      Get.offNamed(
        Routes.CHAT_DETAIL,
        arguments: {
          'lawyerId': offer.value!.lawyerId,
          'lawyerName': offer.value!.lawyerName,
        },
      );
    } catch (e) {
      print('Error accepting offer: $e');

      // Show error message
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء قبول العرض',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

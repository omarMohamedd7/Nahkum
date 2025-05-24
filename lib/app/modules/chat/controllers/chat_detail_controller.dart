import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';

class ChatDetailController extends GetxController {
  final Rx<ChatModel?> selectedChat = Rx<ChatModel?>(null);
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxString newMessage = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get the chat from arguments
    if (Get.arguments != null && Get.arguments['chat'] != null) {
      selectedChat.value = Get.arguments['chat'];
      fetchMessages();
    }
  }

  void fetchMessages() {
    isLoading.value = true;

    try {
      // This is a placeholder for actual API calls
      // In a real app, you would fetch data from a service
      Future.delayed(const Duration(milliseconds: 500), () {
        messages.value = [
          {
            'id': '1',
            'text': 'مرحبا، كيف يمكنني المساعدة في قضيتك؟',
            'isFromLawyer': true,
            'timestamp':
                DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          },
          {
            'id': '2',
            'text': 'أحتاج استشارة قانونية حول إجراءات توثيق عقد إيجار.',
            'isFromLawyer': false,
            'timestamp': DateTime.now()
                .subtract(const Duration(days: 1, hours: 1, minutes: 45)),
          },
          {
            'id': '3',
            'text':
                'بالتأكيد، يمكنني مساعدتك. هل لديك صورة من العقد الذي تريد توثيقه؟',
            'isFromLawyer': true,
            'timestamp': DateTime.now()
                .subtract(const Duration(days: 1, hours: 1, minutes: 30)),
          },
          {
            'id': '4',
            'text': 'نعم، سأرسل لك صورة من العقد خلال ساعات.',
            'isFromLawyer': false,
            'timestamp':
                DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          },
          {
            'id': '5',
            'text': 'تم استلام المستندات، سنتابع الإجراءات ونبلغك بالتطورات',
            'isFromLawyer': true,
            'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
          },
        ];
        isLoading.value = false;
      });
    } catch (e) {
      print('Error fetching messages: $e');
      isLoading.value = false;
    }
  }

  void sendMessage() {
    if (newMessage.trim().isEmpty) return;

    final message = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'text': newMessage.value,
      'isFromLawyer': false,
      'timestamp': DateTime.now(),
    };

    messages.add(message);
    newMessage.value = '';
  }
}

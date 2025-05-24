import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../routes/app_routes.dart';

class ChatController extends GetxController {
  // Observable variables
  final RxList<ChatModel> chats = <ChatModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  // Fetch chat list
  void fetchChats() {
    isLoading.value = true;

    try {
      // This is a placeholder for actual API calls
      // In a real app, you would fetch data from a service
      Future.delayed(const Duration(milliseconds: 500), () {
        chats.value = [
          ChatModel(
            id: '1',
            lawyerId: '101',
            lawyerName: 'محمد أحمد',
            lawyerImageUrl: 'assets/images/person.svg',
            lastMessage:
                'تم استلام المستندات، سنتابع الإجراءات ونبلغك بالتطورات',
            lastMessageTime:
                DateTime.now().subtract(const Duration(minutes: 30)),
            isUnread: true,
            caseTitle: 'قضية عقارية',
          ),
          ChatModel(
            id: '2',
            lawyerId: '102',
            lawyerName: 'عمر خالد',
            lawyerImageUrl: 'assets/images/person.svg',
            lastMessage: 'نعم، الموعد مؤكد يوم الخميس القادم الساعة 10 صباحاً',
            lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
            isUnread: false,
            caseTitle: 'استشارة قانونية',
          ),
          ChatModel(
            id: '3',
            lawyerId: '103',
            lawyerName: 'سارة محمود',
            lawyerImageUrl: 'assets/images/person.svg',
            lastMessage: 'تم الانتهاء من إعداد العقد، يمكنك الاطلاع عليه',
            lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
            isUnread: true,
            caseTitle: 'توثيق عقد',
          ),
          ChatModel(
            id: '4',
            lawyerId: '104',
            lawyerName: 'خالد عبدالله',
            lawyerImageUrl: 'assets/images/person.svg',
            lastMessage: 'سأرسل لك التفاصيل حول الإجراءات المطلوبة قريباً',
            lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
            isUnread: false,
            caseTitle: 'قضية تجارية',
          ),
        ];
        isLoading.value = false;
      });
    } catch (e) {
      print('Error fetching chats: $e');
      isLoading.value = false;
    }
  }

  // Navigate to chat detail screen
  void navigateToChatDetail(ChatModel chat) {
    Get.toNamed(Routes.CHAT_DETAIL, arguments: {'chat': chat});
  }

  // Mark a chat as read
  void markChatAsRead(String chatId) {
    final index = chats.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      final updatedChat = chats[index].copyWith(isUnread: false);
      chats[index] = updatedChat;
    }
  }
}

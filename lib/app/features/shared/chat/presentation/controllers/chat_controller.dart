import 'package:get/get.dart';
import 'package:legal_app/app/features/shared/chat/data/models/chat_model.dart';
import 'package:legal_app/app/routes/app_routes.dart';

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
      // Mock data - in a real app, this would come from an API or local database
      Future.delayed(const Duration(milliseconds: 500), () {
        chats.value = [
          ChatModel(
            id: '1',
            lawyerId: 'lawyer1',
            lawyerName: 'محمد أحمد',
            lawyerImageUrl: 'assets/images/avatar1.png',
            lastMessage: 'سيتم تحديد موعد الجلسة القادمة قريباً',
            lastMessageTime:
                DateTime.now().subtract(const Duration(minutes: 30)),
            isUnread: true,
            caseTitle: 'قضية مطالبة مالية',
          ),
          ChatModel(
            id: '2',
            lawyerId: 'lawyer2',
            lawyerName: 'أحمد محمود',
            lawyerImageUrl: 'assets/images/avatar2.png',
            lastMessage: 'تم تقديم المستندات المطلوبة',
            lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
            isUnread: false,
            caseTitle: 'استشارة قانونية',
          ),
          ChatModel(
            id: '3',
            lawyerId: 'lawyer3',
            lawyerName: 'عمر خالد',
            lawyerImageUrl: 'assets/images/avatar3.png',
            lastMessage: 'أتمنى لك التوفيق',
            lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
            isUnread: false,
            caseTitle: 'عقد إيجار',
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
    Get.toNamed(Routes.CHAT_DETAIL, arguments: {
      'id': chat.id,
      'lawyerId': chat.lawyerId,
      'lawyerName': chat.lawyerName,
      'caseTitle': chat.caseTitle,
    });
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

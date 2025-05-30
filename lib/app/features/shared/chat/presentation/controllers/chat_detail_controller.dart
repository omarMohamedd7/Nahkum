import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/features/shared/chat/data/models/message.dart';

class ChatDetailController extends GetxController {
  final Rx<Map<String, dynamic>?> selectedChat =
      Rx<Map<String, dynamic>?>(null);
  final RxList<Message> messages = <Message>[].obs;
  final RxBool isLoading = false.obs;
  final RxString newMessage = ''.obs;

  // ScrollController to manage scrolling to bottom when new messages arrive
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchSelectedChat();
    fetchMessages();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void fetchSelectedChat() {
    isLoading.value = true;

    try {
      // Mock data
      final Map<String, dynamic> chatData = Get.arguments ??
          {
            'id': '1',
            'lawyerId': 'lawyer1',
            'lawyerName': 'محمد أحمد',
            'caseId': 'case1',
            'caseTitle': 'قضية مطالبة مالية',
            'lastMessage': 'مرحباً، كيف يمكنني مساعدتك؟',
            'lastMessageTime':
                DateTime.now().subtract(const Duration(hours: 2)),
            'unreadCount': 0,
          };

      selectedChat.value = chatData;
    } catch (e) {
      print('Error fetching chat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchMessages() {
    isLoading.value = true;

    try {
      // Mock messages data using the Message model - in chronological order
      messages.value = [
        Message.fromLawyer(
          id: '1',
          content: 'مرحباً، كيف يمكنني مساعدتك في قضيتك؟',
        ).copyWith(
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        ),
        Message.fromUser(
          id: '2',
          content: 'أهلاً، أرغب في معرفة آخر تطورات القضية.',
        ).copyWith(
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        ),
        Message.fromLawyer(
          id: '3',
          content:
              'تم تقديم المستندات للمحكمة وننتظر تحديد موعد الجلسة القادمة.',
        ).copyWith(
          timestamp: DateTime.now().subtract(const Duration(hours: 23)),
        ),
      ];

      // Sort messages by timestamp to ensure they're in chronological order
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      // Schedule scrolling to the bottom after the view is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    } catch (e) {
      print('Error fetching messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage() {
    if (newMessage.value.trim().isEmpty) return;

    try {
      // Add new message to the list using the Message model
      messages.add(Message.fromUser(content: newMessage.value));

      // Clear the input field
      newMessage.value = '';

      // Scroll to the bottom to show the new message
      scrollToBottom();

      // Simulate lawyer response after a delay
      Future.delayed(const Duration(seconds: 2), () {
        messages.add(Message.fromLawyer(
          content: 'شكراً لتواصلك، سأقوم بالرد قريباً.',
        ));

        // Scroll to the bottom again to show the lawyer's response
        scrollToBottom();
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // Helper method to scroll to the bottom of the list
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}

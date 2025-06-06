import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legal_app/app/features/shared/chat/data/models/message.dart';
import 'package:legal_app/app/core/data/services/firebase_chat-service.dart';

class ChatDetailController extends GetxController {
  final FirebaseChatService _chatService = FirebaseChatService();

  final messages = <Message>[].obs;
  final isLoading = false.obs;
  final newMessage = ''.obs;
  final scrollController = ScrollController();

  final selectedChat = Rxn<Map<String, dynamic>>();

  late String chatId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    chatId = args['id'];
    selectedChat.value = args;
    listenToMessages();
  }

  void listenToMessages() {
    isLoading.value = true;
    _chatService.getMessagesStream(chatId).listen((data) {
      messages.assignAll(data);
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });
      isLoading.value = false;
    });
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  Future<void> sendMessage() async {
    final text = newMessage.value.trim();
    if (text.isEmpty) return;

    final message = Message(
      id: '',
      content: text,
      isFromUser: true, // 🔁 عدّل حسب الدور الحقيقي إذا أردت
      timestamp: DateTime.now(),
    );

    await _chatService.sendMessage(chatId: chatId, message: message);

    // اختياري: تحديث آخر رسالة في قائمة المحادثات
    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': DateTime.now(),
      'isUnread': true,
    });

    newMessage.value = '';
  }
}

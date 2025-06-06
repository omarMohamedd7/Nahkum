import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legal_app/app/features/shared/chat/data/models/chat_model.dart';
import 'package:legal_app/app/routes/app_routes.dart';

import '../../../../../core/data/services/firebase_chat-service.dart';

class ChatController extends GetxController {
  final chats = <ChatModel>[].obs;
  final isLoading = false.obs;
  final searchController = TextEditingController();
  final allChats = <ChatModel>[]; // كل المحادثات الأصلية
  final searchResults = <Map<String, dynamic>>[].obs; // نتائج البحث عن المستخدمين

  final FirebaseChatService _chatService = FirebaseChatService();

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  void fetchChats() async {
    isLoading.value = true;
    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('chats').get();

      final data = snapshot.docs.map((doc) {
        final d = doc.data();
        return ChatModel(
          id: doc.id,
          lawyerId: d['lawyerId'] ?? '',
          lawyerName: d['lawyerName'] ?? '',
          lawyerImageUrl: d['lawyerImageUrl'] ?? '',
          lastMessage: d['lastMessage'] ?? '',
          lastMessageTime: (d['lastMessageTime'] as Timestamp?)?.toDate() ??
              DateTime.now(),
          isUnread: d['isUnread'] ?? false,
          caseTitle: d['caseTitle'] ?? '',
        );
      }).toList();

      chats.assignAll(data);
      allChats.clear();
      allChats.addAll(data);
    } catch (e) {
      print("Error loading chats: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterChats(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      chats.assignAll(allChats);
      return;
    }

    final lower = query.toLowerCase();
    chats.assignAll(allChats.where((chat) =>
    chat.lawyerName.toLowerCase().contains(lower) ||
        chat.caseTitle.toLowerCase().contains(lower)));

    // 🔍 بحث في قاعدة البيانات الحقيقية عن المستخدمين
    final results = await _chatService.searchUsersByName(query);
    searchResults.assignAll(results);
  }

  void navigateToChatDetail(ChatModel chat) {
    Get.toNamed(Routes.CHAT_DETAIL, arguments: {
      'id': chat.id,
      'lawyerName': chat.lawyerName,
      'caseTitle': chat.caseTitle,
    });
  }

  Future<void> startChatWithUser(Map<String, dynamic> user) async {
    final userId = user['id'];
    final name = user['name'];
    final role = user['role'];

    final chatId = generateChatId(userId); // طريقة لإنشاء معرف فريد للمحادثة

    await _chatService.createOrUpdateChat(
      chatId: chatId,
      lawyerName: name,
      caseTitle: 'بدون عنوان',
      lawyerId: userId,
      lawyerImageUrl: user['profileImage'],
    );

    Get.toNamed(Routes.CHAT_DETAIL, arguments: {
      'id': chatId,
      'lawyerName': name,
      'caseTitle': 'بدون عنوان',
    });

    searchResults.clear(); // لإخفاء نتائج البحث بعد بدء المحادثة
  }

  // 💡 إنشاء chatId بناء على الـ userId (يمكنك تخصيصها حسب نظامك)
  String generateChatId(String otherUserId) {
    // لنفترض أن المستخدم الحالي رقمه محفوظ هنا
    const currentUserId = 'current_logged_user_id';
    final sorted = [currentUserId, otherUserId]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }
}

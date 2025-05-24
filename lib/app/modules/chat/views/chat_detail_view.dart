import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:legal_app/app/theme/app_colors.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() {
          final chat = controller.selectedChat.value;
          if (chat == null) return const Text('محادثة');

          return Text(
            chat.lawyerName,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Almarai',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCaseInfoBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return _buildEmptyChat();
              }

              return _buildMessagesList();
            }),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildCaseInfoBar() {
    return Obx(() {
      final chat = controller.selectedChat.value;
      if (chat == null) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppColors.primary.withOpacity(0.1),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'القضية: ${chat.caseTitle}',
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      reverse: true,
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final reversedIndex = controller.messages.length - 1 - index;
        final message = controller.messages[reversedIndex];
        final isFromLawyer = message['isFromLawyer'] as bool;
        final text = message['text'] as String;
        final timestamp = message['timestamp'] as DateTime;

        return _buildMessageBubble(
          message: text,
          isFromLawyer: isFromLawyer,
          timestamp: timestamp,
        );
      },
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required bool isFromLawyer,
    required DateTime timestamp,
  }) {
    return Align(
      alignment: isFromLawyer ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isFromLawyer ? Colors.white : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isFromLawyer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                color: isFromLawyer ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(timestamp),
              style: TextStyle(
                fontSize: 10,
                color:
                    isFromLawyer ? Colors.grey : Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey),
            onPressed: () {
              // Handle attachment
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.grey),
            onPressed: () {
              // Handle camera
            },
          ),
          Expanded(
            child: TextField(
              onChanged: (value) => controller.newMessage.value = value,
              decoration: const InputDecoration(
                hintText: 'اكتب رسالة...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 16),
              onPressed: () => controller.sendMessage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_chat.svg',
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'ابدأ المحادثة الآن',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'اكتب رسالة للمحامي للبدء في المحادثة',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate == today) {
      return DateFormat('HH:mm').format(timestamp);
    } else if (messageDate == yesterday) {
      return 'أمس ${DateFormat('HH:mm').format(timestamp)}';
    } else {
      return DateFormat('yyyy/MM/dd HH:mm').format(timestamp);
    }
  }
}

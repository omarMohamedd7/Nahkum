import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legal_app/app/features/shared/chat/data/models/message.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final String senderName;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.senderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use default locale instead of 'ar' to avoid initialization issues
    final timeFormat = DateFormat('h:mm a');
    final isUser = message.isFromUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isUser ? 64 : 0,
          right: isUser ? 0 : 64,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isUser ? const Radius.circular(0) : null,
            bottomLeft: !isUser ? const Radius.circular(0) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  senderName,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isUser ? Colors.white70 : AppColors.primary,
                  ),
                ),
              ),
            Text(
              message.content,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                color: isUser ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                timeFormat.format(message.timestamp),
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 10,
                  color: isUser ? Colors.white70 : Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

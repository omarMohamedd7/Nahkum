import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:legal_app/app/theme/app_colors.dart';

import '../../../data/models/chat_model.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatCard({
    Key? key,
    required this.chat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            // Left arrow icon
            SvgPicture.asset(
              'assets/images/arrow-right.svg',
              height: 20,
              width: 20,
              color: const Color(0xFF181E3C),
            ),

            const SizedBox(width: 12),

            // Name and last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Lawyer name
                  Text(
                    chat.lawyerName,
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF181E3C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Message + time in one row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Almarai',
                            fontSize: 12,
                            color: Color(0xFFB8B8B8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatTime(chat.lastMessageTime),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFFB8B8B8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Right side image with unread indicator
            Stack(
              children: [
                _buildLawyerImage(),
                if (chat.isUnread)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLawyerImage() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      backgroundImage: chat.lawyerImageUrl.startsWith('http')
          ? NetworkImage(chat.lawyerImageUrl)
          : null,
      child: chat.lawyerImageUrl.endsWith('.svg')
          ? SvgPicture.asset(
              chat.lawyerImageUrl,
              width: 24,
              height: 24,
              color: AppColors.primary,
            )
          : (!chat.lawyerImageUrl.startsWith('http')
              ? const Icon(Icons.person, color: AppColors.primary)
              : null),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return DateFormat('HH:mm').format(time); // Today: 14:30
    } else if (messageDate == yesterday) {
      return 'أمس'; // Yesterday
    } else {
      return DateFormat('MM/dd').format(time); // Older: 05/20
    }
  }
}

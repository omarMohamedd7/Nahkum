import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/chat.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
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

            // Right side image
            _buildLawyerImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildLawyerImage() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      backgroundImage: chat.lawyerImageUrl != null
          ? NetworkImage(chat.lawyerImageUrl!)
          : null,
      child: chat.lawyerImageUrl == null
          ? const Icon(Icons.person, color: AppColors.primary)
          : null,
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time); // 24-hour format like 14:30
  }
}

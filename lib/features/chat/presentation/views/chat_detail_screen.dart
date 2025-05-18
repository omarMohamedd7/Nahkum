import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/message_bubble.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;

  const ChatDetailScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading messages from database
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _loadMessages();
        setState(() {
          _isLoading = false;
        });
        // Scroll to bottom after messages are loaded
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    try {
      // In a real app, these would be loaded from a database
      final List<Message> mockMessages = [
        Message(
          id: '1',
          content:
              'مرحباً، أحتاج إلى استشارة قانونية بخصوص ${widget.chat.caseTitle}',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          isFromUser: true,
        ),
        Message(
          id: '2',
          content:
              'مرحباً بك، سعيد بالتواصل معك. يمكنك توضيح المزيد من التفاصيل حول قضيتك؟',
          timestamp: DateTime.now()
              .subtract(const Duration(days: 1, hours: 1, minutes: 50)),
          isFromUser: false,
        ),
        Message(
          id: '3',
          content: 'بالتأكيد، القضية تتعلق بـ...',
          timestamp: DateTime.now()
              .subtract(const Duration(days: 1, hours: 1, minutes: 30)),
          isFromUser: true,
        ),
        Message(
          id: '4',
          content:
              'شكراً على التوضيح. بناءً على ما ذكرته، أنصحك بالخطوات التالية...',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          isFromUser: false,
        ),
        Message(
          id: '5',
          content: widget.chat.lastMessage,
          timestamp: widget.chat.lastMessageTime,
          isFromUser: false,
        ),
      ];

      setState(() {
        _messages.addAll(mockMessages);
      });
    } catch (e) {
      debugPrint('Error loading messages: $e');
      // Show error state or retry
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _messageController.text,
      timestamp: DateTime.now(),
      isFromUser: true,
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    _scrollToBottom();

    // Simulate lawyer response after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final response = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content:
              'شكراً لتواصلك، سأقوم بدراسة الموضوع والرد عليك في أقرب وقت.',
          timestamp: DateTime.now(),
          isFromUser: false,
        );

        setState(() {
          _messages.add(response);
        });

        _scrollToBottom();
      }
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'إرفاق',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(
                  context,
                  icon: Icons.image,
                  label: 'صورة',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement image picking
                  },
                ),
                _buildAttachmentOption(
                  context,
                  icon: Icons.camera_alt,
                  label: 'كاميرا',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement camera
                  },
                ),
                _buildAttachmentOption(
                  context,
                  icon: Icons.file_present,
                  label: 'ملف',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement file picking
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      // Log error but don't crash
      debugPrint('Error scrolling to bottom: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => AppRouter.instance.goBack(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: _buildLawyerAvatar(),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.lawyerName,
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'متصل الآن',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Chat messages
                Expanded(
                  child: _messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'لا توجد رسائل',
                                style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            try {
                              final message = _messages[index];
                              final showTimestamp = index == 0 ||
                                  _shouldShowTimestamp(
                                    _messages[index].timestamp,
                                    _messages[index - 1].timestamp,
                                  );

                              return Column(
                                children: [
                                  if (showTimestamp)
                                    _buildTimestampDivider(message.timestamp),
                                  MessageBubble(
                                    message: message,
                                    senderName: message.isFromUser
                                        ? 'أنت'
                                        : widget.chat.lawyerName,
                                  ),
                                ],
                              );
                            } catch (e) {
                              // Return an error widget instead of crashing
                              debugPrint(
                                  'Error rendering message at index $index: $e');
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                ),
                // Input field
                ChatInputField(
                  controller: _messageController,
                  onSendPressed: _handleSendMessage,
                  onAttachmentPressed: _handleAttachmentPressed,
                ),
              ],
            ),
    );
  }

  bool _shouldShowTimestamp(DateTime current, DateTime previous) {
    // Show timestamp if more than 30 minutes between messages
    return current.difference(previous).inMinutes > 30;
  }

  Widget _buildTimestampDivider(DateTime timestamp) {
    final dateFormat = DateFormat.yMMMd('ar');
    final timeFormat = DateFormat.jm('ar');
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    String formattedDate;
    if (difference.inDays == 0) {
      formattedDate = 'اليوم';
    } else if (difference.inDays == 1) {
      formattedDate = 'الأمس';
    } else {
      formattedDate = dateFormat.format(timestamp);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '$formattedDate - ${timeFormat.format(timestamp)}',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLawyerAvatar() {
    if (widget.chat.lawyerImageUrl.endsWith('.svg')) {
      // Handle SVG image
      return SvgPicture.asset(
        widget.chat.lawyerImageUrl,
        width: 24,
        height: 24,
        color: AppColors.primary,
        placeholderBuilder: (BuildContext context) => const Icon(
          Icons.person,
          size: 24,
          color: AppColors.primary,
        ),
      );
    } else {
      // Handle regular images or fallback to icon
      return const Icon(
        Icons.person,
        size: 24,
        color: AppColors.primary,
      );
    }
  }
}

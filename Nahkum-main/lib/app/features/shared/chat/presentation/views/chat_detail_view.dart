import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/core/utils/responsive_utils.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontSize = ResponsiveUtils.getFontSize(context, smallSize: 14);
    final double iconSize = ResponsiveUtils.getIconSize(context, smallSize: 18);
    final double padding =
        ResponsiveUtils.getPadding(context, smallPadding: 12);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() {
          final chat = controller.selectedChat.value;
          if (chat == null) return const Text('محادثة');

          return Text(
            chat['lawyerName'],
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Almarai',
              fontSize: fontSize + 2,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.arrowRight,
              color: AppColors.primary,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCaseInfoBar(context),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return _buildEmptyChat(context);
              }

              return _buildMessagesList(context);
            }),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildCaseInfoBar(BuildContext context) {
    final double fontSize = ResponsiveUtils.getFontSize(context, smallSize: 11);
    final double iconSize = ResponsiveUtils.getIconSize(context, smallSize: 16);
    final double padding =
        ResponsiveUtils.getPadding(context, smallPadding: 12);

    return Obx(() {
      final chat = controller.selectedChat.value;
      if (chat == null) return const SizedBox.shrink();

      return Container(
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        color: AppColors.primary.withOpacity(0.1),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: iconSize,
            ),
            SizedBox(width: ResponsiveUtils.getWidthPercentage(context, 2)),
            Expanded(
              child: Text(
                'القضية: ${chat['caseTitle']}',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: fontSize,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMessagesList(BuildContext context) {
    final double padding =
        ResponsiveUtils.getPadding(context, smallPadding: 12);

    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      reverse: false,
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];

        return _buildMessageBubble(
          context: context,
          message: message.content,
          isFromLawyer: !message.isFromUser,
          timestamp: message.timestamp,
        );
      },
    );
  }

  Widget _buildMessageBubble({
    required BuildContext context,
    required String message,
    required bool isFromLawyer,
    required DateTime timestamp,
  }) {
    final double fontSize = ResponsiveUtils.getFontSize(context, smallSize: 13);
    final double timeSize = ResponsiveUtils.getFontSize(context, smallSize: 9);
    final double padding =
        ResponsiveUtils.getPadding(context, smallPadding: 12);

    return Align(
      alignment: isFromLawyer ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: padding),
        constraints: BoxConstraints(
          maxWidth: ResponsiveUtils.getWidthPercentage(context, 70),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.75),
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
                fontSize: fontSize,
                color: isFromLawyer ? Colors.black : Colors.white,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getHeightPercentage(context, 0.5)),
            Text(
              _formatTimestamp(timestamp),
              style: TextStyle(
                fontSize: timeSize,
                color:
                    isFromLawyer ? Colors.grey : Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final double iconSize = ResponsiveUtils.getIconSize(context, smallSize: 18);
    final double sendIconSize =
        ResponsiveUtils.getIconSize(context, smallSize: 14);
    final double fontSize = ResponsiveUtils.getFontSize(context, smallSize: 13);
    final double padding =
        ResponsiveUtils.getPadding(context, smallPadding: 12);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
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
            icon: Icon(Icons.attach_file, color: Colors.grey, size: iconSize),
            onPressed: () {
              // Handle attachment
            },
            constraints: BoxConstraints(
              minWidth: ResponsiveUtils.getWidthPercentage(context, 8),
              minHeight: ResponsiveUtils.getWidthPercentage(context, 8),
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.grey, size: iconSize),
            onPressed: () {
              // Handle camera
            },
            constraints: BoxConstraints(
              minWidth: ResponsiveUtils.getWidthPercentage(context, 8),
              minHeight: ResponsiveUtils.getWidthPercentage(context, 8),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) => controller.newMessage.value = value,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(
                hintText: 'اكتب رسالة...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontSize: fontSize),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: padding / 2, vertical: padding / 2),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: ResponsiveUtils.getWidthPercentage(context, 5),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white, size: sendIconSize),
              onPressed: () => controller.sendMessage(),
              constraints: BoxConstraints(
                minWidth: ResponsiveUtils.getWidthPercentage(context, 10),
                minHeight: ResponsiveUtils.getWidthPercentage(context, 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChat(BuildContext context) {
    final double titleFontSize =
        ResponsiveUtils.getFontSize(context, smallSize: 16);
    final double subtitleFontSize =
        ResponsiveUtils.getFontSize(context, smallSize: 12);
    final double imageSize = ResponsiveUtils.getWidthPercentage(context, 30);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_chat.svg',
            height: imageSize,
            width: imageSize,
          ),
          SizedBox(height: ResponsiveUtils.getHeightPercentage(context, 3)),
          Text(
            'ابدأ المحادثة الآن',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getHeightPercentage(context, 1)),
          Text(
            'اكتب رسالة للمحامي للبدء في المحادثة',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: subtitleFontSize,
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
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      // More than a week, show the date
      return DateFormat('dd/MM/yyyy').format(timestamp);
    } else if (difference.inDays > 0) {
      // Within a week but not today
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      // Today but not within the hour
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      // Within the hour
      return '${difference.inMinutes} دقيقة';
    } else {
      // Just now
      return 'الآن';
    }
  }
}

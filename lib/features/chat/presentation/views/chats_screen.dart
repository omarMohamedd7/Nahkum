import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../home/presentation/widgets/bottom_navigation_bar.dart';
import '../../domain/entities/chat.dart';
import '../widgets/chat_card.dart';
import 'chat_detail_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample chat data - would come from a provider in a real app
    final List<Chat> chats = [
      Chat(
        id: '1',
        lawyerId: '101',
        lawyerName: 'محمد أحمد',
        lawyerImageUrl: 'assets/images/person.svg',
        lastMessage: 'تم استلام المستندات، سنتابع الإجراءات ونبلغك بالتطورات',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
        isUnread: true,
        caseTitle: 'قضية عقارية',
      ),
      Chat(
        id: '2',
        lawyerId: '102',
        lawyerName: 'عمر خالد',
        lawyerImageUrl: 'assets/images/person.svg',
        lastMessage: 'نعم، الموعد مؤكد يوم الخميس القادم الساعة 10 صباحاً',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
        isUnread: false,
        caseTitle: 'استشارة قانونية',
      ),
      Chat(
        id: '3',
        lawyerId: '103',
        lawyerName: 'سارة محمود',
        lawyerImageUrl: 'assets/images/person.svg',
        lastMessage: 'تم الانتهاء من إعداد العقد، يمكنك الاطلاع عليه',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        isUnread: true,
        caseTitle: 'توثيق عقد',
      ),
      Chat(
        id: '4',
        lawyerId: '104',
        lawyerName: 'خالد عبدالله',
        lawyerImageUrl: 'assets/images/person.svg',
        lastMessage: 'سأرسل لك التفاصيل حول الإجراءات المطلوبة قريباً',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
        isUnread: false,
        caseTitle: 'قضية تجارية',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(top: 21.0, bottom: 32.0),
                child: Text(
                  'المحادثات',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Chat list
              Expanded(
                child: chats.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        itemCount: chats.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return ChatCard(
                            chat: chats[index],
                            onTap: () {
                              // Navigate to chat detail screen using the router
                              AppRouter.instance
                                  .navigateToChatDetail(context, chats[index]);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_chats.svg',
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'لا توجد محادثات',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'عند بدء محادثة مع محامي، ستظهر هنا',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
              color: Color(0xFF737373),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

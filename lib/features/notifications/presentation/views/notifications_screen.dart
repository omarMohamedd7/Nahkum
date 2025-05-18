import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_router.dart';
import '../widgets/notification_card.dart';
import '../../domain/entities/notification.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notification data
    final List<NotificationItem> notifications = [
      NotificationItem(
        id: '1',
        title: 'تم قبول طلب التوكيل',
        description:
            'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
        time: '2:43 am',
      ),
      NotificationItem(
        id: '2',
        title: 'تم قبول طلب التوكيل',
        description:
            'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
        time: '2:43 am',
      ),
      NotificationItem(
        id: '3',
        title: 'تم قبول طلب التوكيل',
        description:
            'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
        time: '2:43 am',
      ),
      NotificationItem(
        id: '4',
        title: 'تم قبول طلب التوكيل',
        description:
            'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
        time: '2:43 am',
      ),
      NotificationItem(
        id: '5',
        title: 'تم قبول طلب التوكيل',
        description:
            'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
        time: '2:43 am',
      ),
      NotificationItem(
        id: '6',
        title: 'تم قبول طلب التوكيل',
        description:
            'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
        time: '2:43 am',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Background color from Figma
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.only(top: 21.0, bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => AppRouter.instance.goBack(context),
                      child: SvgPicture.asset(
                        'assets/images/arrow-right.svg',
                        width: 24,
                        height: 24,
                        color: const Color(0xFF181E3C),
                      ),
                    ),
                    const Text(
                      'الإشعارات',
                      style: TextStyle(
                        color: Color(0xFF181E3C),
                        fontFamily: 'Almarai',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Empty container for alignment
                    const SizedBox(width: 24),
                  ],
                ),
              ),

              // Notifications List
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationCard(
                      title: notification.title,
                      description: notification.description,
                      time: notification.time,
                      notificationIconPath: 'assets/images/notification2.svg',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

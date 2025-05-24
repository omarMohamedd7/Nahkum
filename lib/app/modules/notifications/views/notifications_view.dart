import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:legal_app/app/modules/notifications/widgets/notification_card.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
                      onTap: controller.goBack,
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
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFC8A45D),
                      ),
                    );
                  }

                  if (controller.notifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/notification.svg',
                            width: 64,
                            height: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'لا توجد إشعارات',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = controller.notifications[index];
                      return NotificationCard(
                        title: notification.title,
                        description: notification.description,
                        time: notification.time,
                        notificationIconPath: 'assets/images/notification2.svg',
                        onTap: () => controller.markAsRead(notification.id),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

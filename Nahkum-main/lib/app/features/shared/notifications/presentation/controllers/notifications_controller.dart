import 'package:get/get.dart';
import '../../data/models/notification_model.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    isLoading.value = true;
    // Simulate API call with dummy data
    Future.delayed(const Duration(milliseconds: 800), () {
      notifications.value = [
        NotificationModel(
          id: '1',
          title: 'تم قبول طلب التوكيل',
          description:
              'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
          time: '2:43 am',
        ),
        NotificationModel(
          id: '2',
          title: 'تم قبول طلب التوكيل',
          description:
              'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
          time: '2:43 am',
        ),
        NotificationModel(
          id: '3',
          title: 'تم قبول طلب التوكيل',
          description:
              'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
          time: '2:43 am',
        ),
        NotificationModel(
          id: '4',
          title: 'تم قبول طلب التوكيل',
          description:
              'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
          time: '2:43 am',
        ),
        NotificationModel(
          id: '5',
          title: 'تم قبول طلب التوكيل',
          description:
              'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
          time: '2:43 am',
        ),
        NotificationModel(
          id: '6',
          title: 'تم قبول طلب التوكيل',
          description:
              'قام المحامي [اسم المحامي] بقبول طلب التوكيل الخاص بك. يمكنك الآن بدء المحادثة ومتابعة قضيتك.',
          time: '2:43 am',
        ),
      ];
      isLoading.value = false;
    });
  }

  void markAsRead(String id) {
    final index =
        notifications.indexWhere((notification) => notification.id == id);
    if (index != -1) {
      final notification = notifications[index];
      notifications[index] = notification.copyWith(isRead: true);
    }
  }

  void deleteNotification(String id) {
    notifications.removeWhere((notification) => notification.id == id);
  }

  void goBack() {
    Get.back();
  }
}

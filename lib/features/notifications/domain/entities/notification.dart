class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String time;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
  });
}

class Chat {
  final String id;
  final String lawyerId;
  final String lawyerName;
  final String lawyerImageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isUnread;
  final String caseTitle;

  const Chat({
    required this.id,
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isUnread,
    required this.caseTitle,
  });
}

class ChatModel {
  final String id;
  final String lawyerId;
  final String lawyerName;
  final String lawyerImageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isUnread;
  final String caseTitle;

  ChatModel({
    required this.id,
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isUnread,
    required this.caseTitle,
  });

  // ✅ تم التعديل هنا: أضفنا copyWith كـ method صحيحة تُعيد نسخة جديدة
  ChatModel copyWith({
    String? id,
    String? lawyerId,
    String? lawyerName,
    String? lawyerImageUrl,
    String? lastMessage,
    DateTime? lastMessageTime,
    bool? isUnread,
    String? caseTitle,
  }) {
    return ChatModel(
      id: id ?? this.id,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      lawyerImageUrl: lawyerImageUrl ?? this.lawyerImageUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      isUnread: isUnread ?? this.isUnread,
      caseTitle: caseTitle ?? this.caseTitle,
    );
  }
}

enum MessageType {
  text,
  image,
  file,
  audio,
  video,
}

class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isFromUser;
  final MessageType type;
  final String? fileUrl; // For image, file, audio, video messages

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isFromUser,
    this.type = MessageType.text,
    this.fileUrl,
  });

  Message copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    bool? isFromUser,
    MessageType? type,
    String? fileUrl,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isFromUser: isFromUser ?? this.isFromUser,
      type: type ?? this.type,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }

  // Method to create a text message from the user
  static Message fromUser({
    required String content,
    String? id,
  }) {
    return Message(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      timestamp: DateTime.now(),
      isFromUser: true,
      type: MessageType.text,
    );
  }

  // Method to create a text message from the lawyer
  static Message fromLawyer({
    required String content,
    String? id,
  }) {
    return Message(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      timestamp: DateTime.now(),
      isFromUser: false,
      type: MessageType.text,
    );
  }
}

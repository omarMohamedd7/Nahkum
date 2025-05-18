class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isFromUser;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isFromUser,
  });
}

enum MessageType {
  text,
  image,
  file,
  audio,
  video,
}

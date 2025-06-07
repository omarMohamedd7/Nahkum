import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/shared/chat/data/models/message.dart';

class FirebaseChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message to Firestore
  Future<void> sendMessage({
    required String chatId,
    required Message message,
  }) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'content': message.content,
      'isFromUser': message.isFromUser,
      'timestamp': message.timestamp.toUtc(),
    });
  }

  // Get messages stream for chat
  Stream<List<Message>> getMessagesStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      return Message(
        id: doc.id,
        content: data['content'],
        isFromUser: data['isFromUser'],
        timestamp: (data['timestamp'] as Timestamp).toDate(),
      );
    }).toList());
  }

  // Create or ensure chat document exists
  Future<void> createOrUpdateChat({
    required String chatId,
    required String lawyerName,
    required String caseTitle,
    String? lawyerId,
    String? lawyerImageUrl,
    String? lastMessage,
    DateTime? lastMessageTime,
    bool? isUnread,
  }) async {
    final docRef = _firestore.collection('chats').doc(chatId);

    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'lawyerName': lawyerName,
        'caseTitle': caseTitle,
        'createdAt': FieldValue.serverTimestamp(),
        'lawyerId': lawyerId ?? '',
        'lawyerImageUrl': lawyerImageUrl ?? '',
        'lastMessage': lastMessage ?? '',
        'lastMessageTime': lastMessageTime ?? DateTime.now(),
        'isUnread': isUnread ?? false,
      });
    }
  }

  // 🔹 Search users by name (client or lawyer)
  Future<List<Map<String, dynamic>>> searchUsersByName(String name) async {
    final result = await _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z')
        .get();

    return result.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'name': data['name'] ?? '',
        'role': data['role'] ?? '',
        'email': data['email'] ?? '',
        'profileImage': data['profileImage'] ?? '',
      };
    }).toList();
  }

  // 🔹 Get single user by ID
  Future<Map<String, dynamic>?> getUserById(String id) async {
    final doc = await _firestore.collection('users').doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data();
    return {
      'id': doc.id,
      'name': data?['name'] ?? '',
      'role': data?['role'] ?? '',
      'email': data?['email'] ?? '',
      'profileImage': data?['profileImage'] ?? '',
    };
  }

  // 🔹 Get chats related to a user (by id)
  Future<List<Map<String, dynamic>>> getChatsByUserId(String userId) async {
    final snapshot = await _firestore
        .collection('chats')
        .where('lawyerId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        ...data,
      };
    }).toList();
  }
}

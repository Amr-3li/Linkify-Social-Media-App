import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/chat/data/model/message_model.dart';
import 'package:linkify/Features/chat/data/web_services/chat_ser.dart';

class ChatSerImplement extends ChatSer {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      String toId) async* {
    try {
      // Query all unread messages in the conversation that were sent to the current user
      final unreadMessages = await firestore
          .collection('chat/${getConversationID(toId)}/messages')
          .where('toId',
              isEqualTo:
                  user.uid) // Ensure only the receiver's messages are updated
          .get();

      // Update all unread messages to "isRead: true" for the receiver
      final batch = firestore.batch();
      for (final doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();

      // Return a stream of all messages in the conversation, ordered by time
      yield* firestore
          .collection('chat/${getConversationID(toId)}/messages')
          .orderBy('time', descending: false)
          .snapshots();
    } catch (e) {
      print("Error fetching messages: $e");
      yield* const Stream.empty();
    }
  }

  @override
  Future<void> sendMessage(
      String toId, String imageURL, String record, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    MessageModel messageModel = MessageModel(
        fromId: user.uid,
        toId: toId,
        lastMessage: true,
        time: time,
        isRead: false,
        recordUrl: record,
        msg: msg,
        imageUrl: imageURL);

    final chatPath = 'chat/${getConversationID(toId)}/messages';

    try {
      await firestore.collection(chatPath).doc(time).set(messageModel.toJson());
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Future<int> countUnreadMessage(String toId) async {
    try {
      final unreadMessageCount = await firestore
          .collection('chat/${getConversationID(toId)}/messages')
          .where('toId', isEqualTo: user.uid)
          .where('isRead', isEqualTo: false)
          .get();
      return unreadMessageCount.size;
    } catch (e) {
      print("Error fetching unread messages count: $e");
      return 0; // في حالة حدوث خطأ، نُرجع 0
    }
  }
}

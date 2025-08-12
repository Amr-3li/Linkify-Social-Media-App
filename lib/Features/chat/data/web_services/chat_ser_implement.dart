import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/chat/data/model/message_model.dart';
import 'package:linkify/Features/chat/data/web_services/chat_ser.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';

class ChatSerImplement implements ChatSer {
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
      final unreadMessages = await firestore
          .collection('chat/${getConversationID(toId)}/messages')
          .where('toId',
              isEqualTo:
                  user.uid) // Ensure only the receiver's messages are updated
          .get();

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
      await firestore
          .collection('chat/${getConversationID(toId)}')
          .doc()
          .set({'lastMessage': msg, 'lastMessageTime': time});
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> countUnreadMessage(String toId) {
    try {
      final unreadMessageCount = firestore
          .collection('chat/${getConversationID(toId)}/messages')
          .where('toId', isEqualTo: user.uid)
          .where('isRead', isEqualTo: false)
          .snapshots();

      return unreadMessageCount;
    } catch (e) {
      return const Stream.empty();
    }
  }
}

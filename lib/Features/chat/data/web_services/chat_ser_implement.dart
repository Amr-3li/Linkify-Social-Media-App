import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/data/web_services/chat_ser.dart';

class ChatSerImplement extends ChatSer {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(String toId) {
    try {
      return firestore
          .collection('chat/${getConversationID(toId)}/messages')
          .orderBy('time', descending: false) // ترتيب حسب الوقت الأحدث
          .snapshots();
    } catch (e) {
      print("Error fetching messages: $e");
      return const Stream.empty();
    }
  }

  @override
  Future<void> sendMessage(String toId, bool isImage, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    MessageModel messageModel = MessageModel(
      fromId: user.uid,
      toId: toId,
      lastMessage: true,
      imageExist: isImage,
      time: time,
      unreadCount: 0, // تبدأ بـ 0 وبعدها تزود حسب الحاجة
      msg: msg,
    );

    final chatPath = 'chat/${getConversationID(toId)}/messages';

    try {
      await firestore.collection(chatPath).doc(time).set(messageModel.toJson());
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}

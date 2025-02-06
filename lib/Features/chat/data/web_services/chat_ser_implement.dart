import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/data/web_services/chat_ser.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ChatSerImplement extends ChatSer {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(UserModel toUser) {
    try {
      return firestore
          .collection('chat/${getConversationID(toUser.id!)}/messages')
          .orderBy('time', descending: false) // ترتيب حسب الوقت الأحدث
          .snapshots();
    } catch (e) {
      print("Error fetching messages: $e");
      return const Stream.empty();
    }
  }

  @override
  Future<void> sendMessage(UserModel toUser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    MessageModel messageModel = MessageModel(
      fromId: user.uid,
      toId: toUser.id!,
      lastMessage: true,
      time: time,
      unreadCount: 0, // تبدأ بـ 0 وبعدها تزود حسب الحاجة
      msg: msg,
    );

    final chatPath = 'chat/${getConversationID(toUser.id!)}/messages';

    try {
      await firestore.collection(chatPath).doc(time).set(messageModel.toJson());
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}

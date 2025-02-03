import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/chat/data/model/message_model.dart';
import 'package:true_gym/Features/chat/data/web_services/message_ser.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class MessageSerImplement extends MessageSer {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  static String getConversationID(String id) {
    return user.uid.hashCode <= id.hashCode
        ? '${user.uid}_$id'
        : '${id}_${user.uid}';
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(UserModel toUser) {
    return firestore
        .collection('chat/${getConversationID(toUser.id!)}/messages')
        .snapshots();
  }

  @override
  Future<void> sendMessage(UserModel toUser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    MessageModel messageModel = MessageModel(
      fromId: user.uid,
      toId: toUser.id!,
      lastMessage: true,
      time: time,
      unreadCount: 5,
      msg: msg,
    );
    await firestore
        .collection('chat/${getConversationID(toUser.id!)}/messages')
        .doc(time)
        .set(messageModel.toJson());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

abstract class ChatSer {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(UserModel toUser);
  Future<void> sendMessage(UserModel toUser, String msg);
}

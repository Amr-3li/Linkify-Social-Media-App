import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatSer {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(String toId);
  Future<void> sendMessage(
      String toId, String imageURL, String record, String msg);
}

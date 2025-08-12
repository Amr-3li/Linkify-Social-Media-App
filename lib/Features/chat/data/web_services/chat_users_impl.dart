import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/chat/data/web_services/chat_users.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class ChatUsersImpl implements ChatUsers {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => FirebaseAuth.instance.currentUser!;
  int count = 0;
  @override
  Future<List<UserModel>> getChatUsers() async {
    try {
      final List<dynamic> myFriendIds = await _getFriendIds();

      if (myFriendIds.isEmpty) return [];

      const int batchSize = 10;
      final List<UserModel> users = [];

      for (int i = 0; i < myFriendIds.length; i += batchSize) {
        final batchIds = myFriendIds.sublist(
            i,
            i + batchSize > myFriendIds.length
                ? myFriendIds.length
                : i + batchSize);

        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId, whereIn: batchIds)
            .get();

        users.addAll(
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList(),
        );
      }
      return users;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw 'An unexpected error occurred.';
    }
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getChatUsers() {
  //   final currentUserId = user.uid;
  //   final snapshot = firestore
  //       .collection(
  //           'chat/${getConversationID("TwzQu696IJa687cu1L4HsvVzPSK2")}/messages')
  //       .orderBy('time', descending: true)
  //       .snapshots();
  //   print(snapshot.length);
  //   return snapshot;
  // }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  Future<List<dynamic>> _getFriendIds() async {
    final currentUserId = user.uid;
    final snapshot = await firestore
        .collection('friendRequests')
        .where('status', isEqualTo: Constants.accepted)
        .where(Filter.or(
          Filter('senderId', isEqualTo: currentUserId),
          Filter('receiverId', isEqualTo: currentUserId),
        ))
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return data['senderId'] == currentUserId
          ? data['receiverId']
          : data['senderId'];
    }).toList();
  }
}

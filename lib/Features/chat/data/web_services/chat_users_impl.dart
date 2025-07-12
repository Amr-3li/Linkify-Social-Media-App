import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/chat/data/web_services/chat_users.dart';

class ChatUsersImpl implements ChatUsers {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => FirebaseAuth.instance.currentUser!;

  // @override

  // Stream<QuerySnapshot<List<UserModel>>> getChatUsers() {
  //    final friendIds = _getFriendIds();

  //  final stream = firestore
  //       .collection('users')
  //       .where('id', isNotEqualTo: user.uid)
  //       .snapshots();

  // }
  // Future<List<dynamic>> _getFriendIds() async {
  //   final currentUserId =  user.uid;
  //   final snapshot = await firestore
  //       .collection('friendRequests')
  //       .where('status', isEqualTo: Constants.accepted)
  //       .where(Filter.or(
  //         Filter('senderId', isEqualTo: currentUserId),
  //         Filter('receiverId', isEqualTo: currentUserId),
  //       ))
  //       .get();
  //   return snapshot.docs.map((doc) {
  //     final data = doc.data();
  //     return data['senderId'] == currentUserId
  //         ? data['receiverId']
  //         : data['senderId'];
  //   }).toList();
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart'
    show Filter, FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/posts/data/services/post_serv.dart';
import 'package:linkify/core/constants/constants.dart';

class AddPostImpl implements AddPost {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User get user => auth.currentUser!;

  @override
  Future<void> addPost(PostModel post) async {
    await firestore.collection('posts').doc(post.time).set(post.toJson());
    final friendIds = await _getFriendIds();
    for (String id in friendIds) {
      await firestore
          .collection('users')
          .doc(id)
          .collection('timeline')
          .doc(post.time)
          .set(post.toJson());
    }
  }

  Future<List<dynamic>> _getFriendIds() async {
    final currentUserId = user.uid;

    final querySnapshot = await firestore
        .collection('friendRequests')
        .where('status', isEqualTo: Constants.accepted)
        .where(
          Filter.or(
            Filter('senderId', isEqualTo: currentUserId),
            Filter('receiverId', isEqualTo: currentUserId),
          ),
        )
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return data['senderId'] == currentUserId
          ? data['receiverId']
          : data['senderId'];
    }).toList();
  }
}

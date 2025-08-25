import 'package:cloud_firestore/cloud_firestore.dart'
    show Filter, FirebaseFirestore, FirebaseException;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/add_post/data/services/post_serv.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';

class AddPostImpl implements AddPost {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User get user => auth.currentUser!;

  @override
  Future<void> addPost(PostModel post) async {
    try {
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
      NotificationModel notification = NotificationModel(
        time: post.time,
        fromUserId: user.uid,
        fromUserName: "Me",
        fromUserImage: user.photoURL,
        isreading: false,
        numOfTypeReations: 0,
        discription: "you add new post",
        type: 'addPost',
        postId: post.time,
      );
      firestore
          .collection('users')
          .doc(user.uid)
          .collection('notifications')
          .doc(post.time)
          .set(notification.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "sorry something went wrong";
    }
  }

  Future<List<dynamic>> _getFriendIds() async {
    try {
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

      final friendIds = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return data['senderId'] == currentUserId
            ? data['receiverId']
            : data['senderId'];
      }).toList(); // include self
      friendIds.add(currentUserId);
      return friendIds;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }
}

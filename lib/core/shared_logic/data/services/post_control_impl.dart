import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/shared_logic/data/services/post_control.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostControlImpl implements PostControl {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;
  SharedPreferences? prefs;
  @override
  Future<void> deletePost(String userId, String time) async {
    if (userId == user.uid) {
      await firestore.collection('posts').doc(time).delete();
    } else {
      throw Exception("You can't delete this post");
    }
  }

  @override
  Future<void> updatePost(
      String description, String userId, String time) async {
    if (userId == user.uid) {
      await firestore
          .collection('posts')
          .doc(time)
          .update({'description': description});
    } else {
      throw Exception("You can't edit this post");
    }
  }

  @override
  Future<void> addComment(String postTime, CommentModel comment) async {
    prefs = await SharedPreferences.getInstance();

    final docRef = firestore.collection('posts').doc(postTime);
    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw Exception('Post Not Found');
    }
    final data = docSnapshot.data();
    final post = PostModel.fromJson(data!);
    final updatedComments = post.comments.map((e) => e.toMap()).toList();
    updatedComments.add(comment.toMap());
    await docRef.update({
      'comments': updatedComments,
    });
    NotificationModel notification = NotificationModel(
        time: DateTime.now().microsecondsSinceEpoch.toString(),
        fromUserId: user.uid,
        fromUserName: prefs!.getString('userName') ?? "",
        fromUserImage: prefs!.getString('userImage') ?? "",
        isreading: false,
        numOfTypeReations: 0,
        discription: "new comment added on your post",
        type: 'addComment',
        postId: postTime);
    await firestore
        .collection('users')
        .doc(post.userId)
        .collection('notifications')
        .doc("$postTime-comment")
        .set(notification.toJson());
  }

  @override
  Future<void> addRemoveLike(String postTime, String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lover = {
        'id': userId,
        'name': prefs.getString('userName') ?? '',
        'image': prefs.getString('userImage') ?? '',
      };
      final docRef = firestore.collection('posts').doc(postTime);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          return;
        }
        final data = snapshot.data()!;
        final likes = List<Map<String, dynamic>>.from(data['likes'] ?? []);
        final currentIndex = likes.indexWhere((e) => e['id'] == userId);
        if (currentIndex != -1) {
          likes.removeAt(currentIndex);
        } else {
          likes.add(lover);
          NotificationModel notification = NotificationModel(
              time: DateTime.now().microsecondsSinceEpoch.toString(),
              fromUserId: user.uid,
              fromUserName: prefs.getString('userName') ?? "",
              fromUserImage: prefs.getString('userImage') ?? "",
              isreading: false,
              numOfTypeReations: data['likes'].length + 1,
              discription: "loved your post",
              type: 'addLove',
              postId: postTime);
          await firestore
              .collection('users')
              .doc(data['userId'])
              .collection('notifications')
              .doc("$postTime-love")
              .set(notification.toJson());
        }
        transaction.update(docRef, {'likes': likes});
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeComment(String postTime, CommentModel comment) async {
    await firestore.collection('posts').doc(postTime).get().then((value) async {
      PostModel post = PostModel.fromJson(value.data()!);
      post.comments.remove(comment);
      await firestore
          .collection('posts')
          .doc(post.time)
          .update({'comments': post.comments});
    });
  }
}

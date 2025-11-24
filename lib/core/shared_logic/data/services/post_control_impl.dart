import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';
import 'package:linkify/core/shared_logic/data/services/post_control.dart';

class PostControlImpl implements PostControl {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;
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
        fromUserName: SharedPreferenceSingelton.getString('userName') ?? "",
        fromUserImage: SharedPreferenceSingelton.getString('userImage') ?? "",
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
  Future<void> addRemoveLike(String postTime) async {
    try {
      final lover = {
        'id': user.uid,
        'name': SharedPreferenceSingelton.getString('userName') ?? '',
        'image': SharedPreferenceSingelton.getString('userImage') ?? '',
      };
      final docRef = firestore.collection('posts').doc(postTime);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          return;
        }
        final data = snapshot.data()!;
        final likes = List<Map<String, dynamic>>.from(data['likes'] ?? []);
        final currentIndex = likes.indexWhere((e) => e['id'] == user.uid);
        if (currentIndex != -1) {
          likes.removeAt(currentIndex);
          await _removeInLoveList(postTime);
        } else {
          likes.add(lover);
          await _addInLoveList(postTime);
          NotificationModel notification = NotificationModel(
              time: DateTime.now().microsecondsSinceEpoch.toString(),
              fromUserId: user.uid,
              fromUserName:
                  SharedPreferenceSingelton.getString('userName') ?? "",
              fromUserImage:
                  SharedPreferenceSingelton.getString('userImage') ?? "",
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

  @override
  Future<void> saveAndUnSavePost(String postTime) async {
    try {
      final isSaved = await firestore
          .collection("userPostsList")
          .doc(user.uid)
          .collection("MySavedPosts")
          .doc(postTime)
          .get();
      if (isSaved.exists) {
        await _removeInSavedList(postTime);
      } else {
        await _addInSavedList(postTime);
      }
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<bool> checkIfPostLoved(String postTime) async {
    try {
      final doc = await firestore.collection('posts').doc(postTime).get();
      bool loved = false;
      if (doc.exists) {
        final data = doc.data();
        final likes = data?['likes'] as List<dynamic>?;

        if (likes != null && likes.isNotEmpty) {
          loved = likes.any(
              (like) => like is Map<String, dynamic> && like['id'] == user.uid);
        }
      }
      return loved;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkIfPostSaved(String postTime) {
    try {
      final doc = firestore
          .collection("userPostsList")
          .doc(user.uid)
          .collection("MySavedPosts")
          .doc(postTime)
          .get();
      return doc.then((value) => value.exists);
    } catch (e) {
      return Future.value(false);
    }
  }

  // local functions

  Future<void> _addInLoveList(String postTime) async {
    final time = DateTime.now().microsecondsSinceEpoch;
    firestore
        .collection("userPostsList")
        .doc(user.uid)
        .collection("MyLovedPosts")
        .doc(postTime)
        .set({"postId": postTime, "createdAt": time});
  }

  Future<void> _removeInLoveList(String postTime) async {
    firestore
        .collection("userPostsList")
        .doc(user.uid)
        .collection("MyLovedPosts")
        .doc(postTime)
        .delete();
  }

  Future<void> _addInSavedList(String postTime) async {
    final time = DateTime.now().microsecondsSinceEpoch;
    firestore
        .collection("userPostsList")
        .doc(user.uid)
        .collection("MySavedPosts")
        .doc(postTime)
        .set({"postId": postTime, "createdAt": time});
  }

  Future<void> _removeInSavedList(String postTime) async {
    firestore
        .collection("userPostsList")
        .doc(user.uid)
        .collection("MySavedPosts")
        .doc(postTime)
        .delete();
  }
}

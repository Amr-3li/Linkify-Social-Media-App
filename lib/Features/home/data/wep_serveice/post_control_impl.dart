import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/wep_serveice/post_control.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostControlImpl implements PostControl {
  final firestore = FirebaseFirestore.instance;
  SharedPreferences? prefs;
  @override
  Future<void> deletePost(PostModel post) async {
    await firestore.collection('posts').doc(post.time).delete();
  }

  @override
  Future<void> updatePost(PostModel post) async {
    await firestore
        .collection('posts')
        .doc(post.time)
        .update({'description': post.description});
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
  }

  @override
  @override
  Future<void> addRemoveLike(String postTime, String userId) async {
    final prefs = await SharedPreferences.getInstance();

    final lover = LoverModel(
      id: userId,
      name: prefs.getString('name')!,
      image: prefs.getString('image')!,
    );

    final docRef = firestore.collection('posts').doc(postTime);

    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) return;

      final post = PostModel.fromJson(snapshot.data()!);
      final likes = List<LoverModel>.from(post.likes);

      final isLiked = likes.any((element) => element.id == userId);

      if (isLiked) {
        likes.removeWhere((element) => element.id == userId);
      } else {
        likes.add(lover);
      }

      transaction.update(docRef, {
        'likes': likes.map((e) => e.toMap()).toList(),
      });
    });
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

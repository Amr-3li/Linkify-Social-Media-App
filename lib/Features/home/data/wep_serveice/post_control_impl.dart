import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/wep_serveice/post_control.dart';

class PostControlImpl implements PostControl {
  final firestore = FirebaseFirestore.instance;

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
    late PostModel post;
    await firestore.collection('posts').doc(postTime).get().then((value) async {
      post = PostModel.fromJson(value.data()!);
      post.comments.add(comment);
      await firestore
          .collection('posts')
          .doc(post.time)
          .update({'comments': post.comments});
    });
  }

  @override
  Future<void> addRemoveLike(String postTime, String userId) async {
    firestore.collection('posts').doc(postTime).get().then((value) async {
      PostModel post = PostModel.fromJson(value.data()!);
      if (post.likes.contains(userId)) {
        post.likes.remove(userId);
      } else {
        post.likes.add(userId);
      }
      await firestore
          .collection('posts')
          .doc(postTime)
          .update({'likes': post.likes});
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

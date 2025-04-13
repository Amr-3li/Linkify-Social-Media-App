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
  Future<void> addRemoveLike(String postTime, String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final lover = {
        'id': userId,
        'name': prefs.getString('userName') ?? '',
        'image': prefs.getString('userImage') ?? '',
      };

      final docRef =
          FirebaseFirestore.instance.collection('posts').doc(postTime);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          print("Post not found.");
          return;
        }

        final data = snapshot.data()!;
        final likes = List<Map<String, dynamic>>.from(data['likes'] ?? []);
        final currentIndex = likes.indexWhere((e) => e['id'] == userId);

        if (currentIndex != -1) {
          // موجود بالفعل، هنشيله
          likes.removeAt(currentIndex);
          print("Like removed");
        } else {
          // مش موجود، نضيفه
          likes.add(lover);
          print("Like added");
        }

        transaction.update(docRef, {'likes': likes});
      });
    } catch (e) {
      print("Error in addRemoveLike: $e");
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

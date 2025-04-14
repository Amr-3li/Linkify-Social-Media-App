import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/shared_logic/data/services/post_control.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostControlImpl implements PostControl {
  final firestore = FirebaseFirestore.instance;
  SharedPreferences? prefs;
  @override
  Future<void> deletePost(String userId, String time) async {
    prefs = await SharedPreferences.getInstance();
    String id = prefs!.getString('uid')!;
    if (userId == id) {
      await firestore.collection('posts').doc(time).delete();
    } else {
      throw Exception("You can't delete this post");
    }
  }

  @override
  Future<void> updatePost(PostModel post) async {
    prefs = await SharedPreferences.getInstance();
    String id = prefs!.getString('uid')!;
    if (post.userId == id) {
      await firestore
          .collection('posts')
          .doc(post.time)
          .update({'description': post.description});
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

      print(lover.toString());

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
          likes.removeAt(currentIndex);
          print("Like removed");
        } else {
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

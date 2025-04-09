import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/wep_serveice/get_posts_serv.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';

class GetPostsServImpl implements GetPostsServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    await firestore
        .collection('posts')
        .orderBy('time', descending: true)
        .get()
        .then((value) {
      posts = value.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
    return posts;
  }

  @override
  Future<List<PostModel>> getUserPosts(String id) async {
    List<PostModel> posts = [];
    await firestore
        .collection('posts')
        .where('uid', isEqualTo: id)
        .get()
        .then((value) {
      posts = value.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
    return posts;
  }

  @override
  Future<List<CommentModel>> getComments(String postTime) async {
    final docSnapshot = await firestore.collection('posts').doc(postTime).get();
    if (!docSnapshot.exists) {
      throw Exception('Post not found');
    }
    final post = PostModel.fromJson(docSnapshot.data()!);
    return post.comments;
  }

  @override
  Future<List<LoverModel>> getLoversPost(String postTime) async {
    List<LoverModel> lovers = [];
    await firestore.collection('posts').doc(postTime).get().then((value) async {
      PostModel post = PostModel.fromJson(value.data()!);
      lovers = post.likes;
    });
    return lovers;
  }
}

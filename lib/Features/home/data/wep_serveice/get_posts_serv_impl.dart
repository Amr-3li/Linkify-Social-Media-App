import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/wep_serveice/get_posts_serv.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';

class GetPostsServImpl implements GetPostsServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    await firestore.collection('posts').get().then((value) {
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/profile/data/services/get_user_posts.dart';

class GetUserPostsImpl implements GetUserPosts {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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

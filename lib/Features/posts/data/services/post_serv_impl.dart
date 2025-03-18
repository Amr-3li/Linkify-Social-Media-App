import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:linkify/Features/posts/data/model/post_model.dart';
import 'package:linkify/Features/posts/data/services/post_serv.dart';

class PostServImpl implements PostServ {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User get user => auth.currentUser!;

  @override
  Future<void> addPost(PostModel post) async {
    int now = DateTime.now().microsecondsSinceEpoch;
    await firestore
        .collection('posts/${user.uid}')
        .doc('$now')
        .set(post.toJson());
  }

  @override
  Future<void> deletePost(PostModel post) async {
    await firestore.collection('posts/${user.uid}').doc(post.time).delete();
  }

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
    await firestore.collection('posts/$id').get().then((value) {
      posts = value.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
    return posts;
  }

  @override
  Future<void> updatePost(PostModel post) async {
    await firestore
        .collection('posts/${user.uid}')
        .doc(post.time)
        .update({'description': post.description});
  }
}

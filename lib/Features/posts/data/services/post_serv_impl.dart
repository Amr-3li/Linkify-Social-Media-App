import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/posts/data/services/post_serv.dart';

class PostServImpl implements PostServ {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User get user => auth.currentUser!;

  @override
  Future<void> addPost(PostModel post) async {
    await firestore.collection('posts').doc(post.time).set(post.toJson());
  }
}

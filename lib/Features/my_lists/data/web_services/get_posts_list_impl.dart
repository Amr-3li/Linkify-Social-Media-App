import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/web_services/get_posts_list.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class GetPostsListImpl implements GetPostsList {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<PostModel>> getLikedPostsList() async {
    try {
      final snapshot = await firestore
          .collection("userPostsList")
          .doc(_getCurrentUserId.toString())
          .collection("MyLikedPosts")
          .get();
      List<PostModel> posts =
          snapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
      return posts;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<PostModel>> getSavedPostsList() async {
    try {
      final snapshot = await firestore
          .collection("userPostsList")
          .doc(_getCurrentUserId.toString())
          .collection("MySavedPosts")
          .get();
      List<PostModel> posts =
          snapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
      return posts;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  Future<String> _getCurrentUserId() async {
    return SharedPreferenceSingelton.getString("uid")!;
  }
}

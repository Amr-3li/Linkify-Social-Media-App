import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/model/my_post_in_list_model.dart';
import 'package:linkify/Features/my_lists/data/web_services/get_posts_list.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class GetPostsListImpl implements GetPostsList {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocLikedList;
  DocumentSnapshot? _lastDocSavedList;
  bool _hasMoreLiked = true;
  bool _hasMoreSaved = true;
  @override
  Future<List<PostModel>> getLikedPostsList() async {
    try {
      final currentUserId = _getCurrentUserId();

      if (!_hasMoreLiked) return [];

      Query query = firestore
          .collection("userPostsList")
          .doc(currentUserId)
          .collection("MyLovedPosts")
          .orderBy("createdAt", descending: true)
          .limit(5);

      if (_lastDocLikedList != null) {
        query = query.startAfterDocument(_lastDocLikedList!);
      }
      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        _hasMoreLiked = false;
        return [];
      }
      _lastDocLikedList = snapshot.docs.last;

      final postsList = snapshot.docs
          .map((e) =>
              MyPostInListModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      if (postsList.isEmpty || postsList.length < 5) {
        _hasMoreLiked = false;
      }
      List<PostModel> postModel = [];

      for (int i = 0; i < postsList.length; i++) {
        final postSnapshot = await firestore
            .collection("posts")
            .doc(postsList[i].postTime)
            .get();

        if (!postSnapshot.exists || postSnapshot.data() == null) {
          continue;
        }
        postModel.add(PostModel.fromJson(postSnapshot.data()!));
      }
      return postModel;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<PostModel>> refreshLikedPostsList() async {
    try {
      final currentUserId = _getCurrentUserId();

      _lastDocLikedList = null;
      _hasMoreLiked = true;

      final snapshot = await firestore
          .collection("userPostsList")
          .doc(currentUserId)
          .collection("MyLovedPosts")
          .orderBy("createdAt", descending: true)
          .limit(5)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocLikedList = snapshot.docs.last;
      }
      final postsList = snapshot.docs
          .map((e) => MyPostInListModel.fromJson(e.data()))
          .toList();

      if (postsList.isEmpty || postsList.length < 5) {
        _hasMoreLiked = false;
      }
      // جلب البوستات الأصلية
      List<PostModel> postModel = [];

      for (int i = 0; i < postsList.length; i++) {
        final postSnapshot = await firestore
            .collection("posts")
            .doc(postsList[i].postTime)
            .get();

        if (!postSnapshot.exists || postSnapshot.data() == null) {
          continue;
        }

        postModel.add(PostModel.fromJson(postSnapshot.data()!));
      }
      return postModel;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<PostModel>> getSavedPostsList() async {
    try {
      final currentUserId = _getCurrentUserId();

      if (!_hasMoreLiked) return [];

      Query query = firestore
          .collection("userPostsList")
          .doc(currentUserId)
          .collection("MySavedPosts")
          .orderBy("createdAt", descending: true)
          .limit(5);

      if (_lastDocLikedList != null) {
        query = query.startAfterDocument(_lastDocLikedList!);
      }
      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        _hasMoreLiked = false;
        return [];
      }

      _lastDocLikedList = snapshot.docs.last;

      final postsList = snapshot.docs
          .map((e) =>
              MyPostInListModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      if (postsList.isEmpty || postsList.length < 5) {
        _hasMoreSaved = false;
      }
      List<PostModel> postModel = [];

      for (int i = 0; i < postsList.length; i++) {
        final postSnapshot = await firestore
            .collection("posts")
            .doc(postsList[i].postTime)
            .get();
        if (!postSnapshot.exists || postSnapshot.data() == null) {
          continue;
        }
        postModel.add(PostModel.fromJson(postSnapshot.data()!));
      }
      return postModel;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<PostModel>> refreshSavedPostsList() async {
    try {
      final currentUserId = _getCurrentUserId();
      _lastDocLikedList = null;
      _hasMoreSaved = true;
      final snapshot = await firestore
          .collection("userPostsList")
          .doc(currentUserId)
          .collection("MySavedPosts")
          .orderBy("createdAt", descending: true)
          .limit(5)
          .get();
      if (snapshot.docs.isNotEmpty) {
        _lastDocLikedList = snapshot.docs.last;
      }
      final postsList = snapshot.docs
          .map((e) => MyPostInListModel.fromJson(e.data()))
          .toList();
      if (postsList.isEmpty || postsList.length < 5) {
        _hasMoreSaved = false;
      }
      List<PostModel> postModel = [];

      for (int i = 0; i < postsList.length; i++) {
        final postSnapshot = await firestore
            .collection("posts")
            .doc(postsList[i].postTime)
            .get();

        if (!postSnapshot.exists || postSnapshot.data() == null) {
          continue;
        }
        postModel.add(PostModel.fromJson(postSnapshot.data()!));
      }
      return postModel;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  String _getCurrentUserId() {
    return SharedPreferenceSingelton.getString("uid")!;
  }
}

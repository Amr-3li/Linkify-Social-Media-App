import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
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
  Future<List<PostModel>> getLikedPostsList({bool loadMore = false}) async {
    try {
      final currentUserId = _getCurrentUserId();

      // لو المستخدم بيطلب صفحة جديدة لكن مفيش بيانات أصلاً
      if (loadMore && !_hasMoreLiked) return [];

      Query query = firestore
          .collection("userPostsList")
          .doc(currentUserId)
          .collection("MyLikedPosts")
          .orderBy("createdAt", descending: true)
          .limit(20);

      // لو بنجيب Page جديدة
      if (loadMore && _lastDocLikedList != null) {
        query = query.startAfterDocument(_lastDocLikedList!);
      }

      final snapshot = await query.get();

      // لو مفيش بيانات جديدة
      if (snapshot.docs.isEmpty) {
        _hasMoreLiked = false;
        return [];
      }

      // تحديث آخر Doc
      _lastDocLikedList = snapshot.docs.last;

      // تحويل البيانات
      return snapshot.docs
          .map((e) => PostModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<PostModel>> getSavedPostsList({bool loadMore = false}) async {
    try {
      final currentUserId = _getCurrentUserId();

      // لو المستخدم بيطلب صفحة جديدة لكن مفيش بيانات أصلاً
      if (loadMore && !_hasMoreSaved) return [];

      Query query = firestore
          .collection("userPostsList")
          .doc(currentUserId)
          .collection("MySavedPosts")
          .orderBy("createdAt", descending: true)
          .limit(20);

      // لو بنجيب Page جديدة
      if (loadMore && _lastDocLikedList != null) {
        query = query.startAfterDocument(_lastDocLikedList!);
      }

      final snapshot = await query.get();

      // لو مفيش بيانات جديدة
      if (snapshot.docs.isEmpty) {
        _hasMoreSaved = false;
        return [];
      }

      // تحديث آخر Doc
      _lastDocLikedList = snapshot.docs.last;

      // تحويل البيانات
      return snapshot.docs
          .map((e) => PostModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  String _getCurrentUserId() {
    return SharedPreferenceSingelton.getString("uid")!;
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
          .collection("MyLikedPosts")
          .orderBy("createdAt", descending: true)
          .limit(20)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocLikedList = snapshot.docs.last;
      }

      return snapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
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
          .limit(20)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocLikedList = snapshot.docs.last;
      }

      return snapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }
}

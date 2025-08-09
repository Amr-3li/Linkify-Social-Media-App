import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/wep_serveice/get_posts_serv.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class GetPostsServImpl implements GetPostsServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<PostModel> glopalPosts = [];
  int postsCount = 0;

  DocumentSnapshot? lastPostDoc;
  @override
  Future<List<PostModel>> getMyTimelinePosts() async {
    try {
      final currentUserId = await _getCurrentUserId();
      Query query = firestore
          .collection('users')
          .doc(currentUserId)
          .collection('timeline')
          .orderBy('time', descending: true)
          .limit(5);
      if (lastPostDoc != null) {
        query = query.startAfterDocument(lastPostDoc!);
      }
      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) return [];
      lastPostDoc = snapshot.docs.last;
      final localPosts = snapshot.docs
          .map((e) => PostModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      glopalPosts.addAll(localPosts);
      return localPosts;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<PostModel> getPost(String postTime) async {
    try {
      final docSnapshot =
          await firestore.collection('posts').doc(postTime).get();
      if (!docSnapshot.exists) {
        throw Exception('Post not found');
      }
      return PostModel.fromJson(docSnapshot.data()!);
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<PostModel>> refreshTimeline() async {
    glopalPosts.clear();
    lastPostDoc = null;
    return await getMyTimelinePosts();
  }

  @override
  Future<List<CommentModel>> getComments(String postTime) async {
    try {
      final docSnapshot =
          await firestore.collection('posts').doc(postTime).get();
      if (!docSnapshot.exists) {
        throw Exception('Post not found');
      }
      final post = PostModel.fromJson(docSnapshot.data()!);
      return post.comments;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<List<LoverModel>> getLoversPost(String postTime) async {
    try {
      List<LoverModel> lovers = [];
      await firestore
          .collection('posts')
          .doc(postTime)
          .get()
          .then((value) async {
        PostModel post = PostModel.fromJson(value.data()!);
        lovers = post.likes;
      });
      return lovers;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  //=====================================================
  // Future<List<String>> _getFriendIds() async {
  //   final currentUserId = await _getCurrentUserId();

  //   final querySnapshot = await firestore
  //       .collection('friendRequests')
  //       .where('status', isEqualTo: Constants.accepted)
  //       .where(
  //         Filter.or(
  //           Filter('senderId', isEqualTo: currentUserId),
  //           Filter('receiverId', isEqualTo: currentUserId),
  //         ),
  //       )
  //       .get();

  //   return querySnapshot.docs.map((doc) {
  //     final data = doc.data();
  //     return data['senderId'] == currentUserId
  //         ? data['receiverId']
  //         : data['senderId'];
  //   }).toList() as List<String>;
  // }

  Future<String> _getCurrentUserId() async {
    return SharedPreferenceSingelton.getString('uid');
  }
}

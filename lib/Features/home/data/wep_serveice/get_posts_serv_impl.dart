import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/wep_serveice/get_posts_serv.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPostsServImpl implements GetPostsServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  SharedPreferences? _prefs;
  List<PostModel> glopalPosts = [];
  int postsCount = 0;

  DocumentSnapshot? lastPostDoc;
  @override
  Future<List<PostModel>> getMyTimelinePosts() async {
    final currentUserId = await _getCurrentUserId();
    Query query = firestore
        .collection('users')
        .doc(currentUserId)
        .collection('timeline')
        .limit(20);
    if (lastPostDoc != null) {
      query = query.startAfterDocument(lastPostDoc!);
    }
    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return glopalPosts;
    lastPostDoc = snapshot.docs.last;
    final localPosts = snapshot.docs
        .map((e) => PostModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    glopalPosts.addAll(localPosts);
    return glopalPosts;
  }

  @override
  Future<List<PostModel>> refreshTimeline() async {
    glopalPosts.clear();
    lastPostDoc = null;
    return await getMyTimelinePosts();
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
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString('uid')!;
  }
}

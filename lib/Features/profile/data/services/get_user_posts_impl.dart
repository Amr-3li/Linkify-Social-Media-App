import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/profile/data/services/get_user_posts.dart';

class GetUserPostsImpl implements GetUserPosts {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<PostModel>> getUserPosts(String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .orderBy('time',
              descending: true) // optional لو عايزهم من الأحدث للأقدم
          .get();

      return querySnapshot.docs.map((doc) {
        print(doc.data().toString());
        return PostModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print('Error getting user posts: $e');
      return [];
    }
  }
}

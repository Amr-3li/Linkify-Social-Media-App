import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/wep_serveice/post_control.dart';

class PostControlImpl implements PostControl {
  get firestore => null;

  @override
  Future<void> deletePost(PostModel post) async {
    await firestore.collection('posts').doc(post.time).delete();
  }

  @override
  Future<void> updatePost(PostModel post) async {
    await firestore
        .collection('posts')
        .doc(post.time)
        .update({'description': post.description});
  }
}

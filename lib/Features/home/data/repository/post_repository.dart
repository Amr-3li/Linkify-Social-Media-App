import 'package:linkify/Features/home/data/Models/post.dart';
import 'package:linkify/core/utils/test_data.dart';

class PostRepository {
  List<Post> getPosts() {
    List<Post> posts = dummyPosts.map((e) => Post.fromJson(e)).toList();
    return posts;
  }
}

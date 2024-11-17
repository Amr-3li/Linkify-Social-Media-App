import 'package:true_gym/Features/home/data/Models/post.dart';
import 'package:true_gym/core/utils/test_data.dart';

class PostRepository {
  List<Post> getPosts() {
    List<Post> posts = dummyPosts.map((e) => Post.fromJson(e)).toList();
    return posts;
  }
}

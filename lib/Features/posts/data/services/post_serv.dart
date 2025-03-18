import 'package:linkify/Features/posts/data/model/post_model.dart';

abstract class PostServ {
  Future<void> addPost(PostModel postModel);
  Future<void> deletePost(PostModel postModel);
  Future<void> updatePost(PostModel postModel);
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> getUserPosts(String id);
}

import 'package:linkify/Features/posts/data/model/post_model.dart';

abstract class PostServ {
  Future<void> addPost(PostModel post);
  Future<void> deletePost(PostModel post);
  Future<void> updatePost(PostModel post);
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> getUserPosts(String id);
}

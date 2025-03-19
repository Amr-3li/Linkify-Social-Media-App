import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class GetPostsServ {
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> getUserPosts(String id);
}

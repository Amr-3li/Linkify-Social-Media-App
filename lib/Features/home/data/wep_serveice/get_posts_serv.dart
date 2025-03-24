import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class GetPostsServ {
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> getUserPosts(String id);
  Future<List<CommentModel>> getComments(String postTime);
  Future<List<LoverModel>> getLoversPost(String postTime);
}

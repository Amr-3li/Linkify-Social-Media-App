import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class GetPostsServ {
  Future<List<PostModel>> getMyTimelinePosts();
  Future<PostModel> getPost(String postTime);
  Future<List<PostModel>> refreshTimeline();
  Future<List<CommentModel>> getComments(String postTime);
  Future<List<LoverModel>> getLoversPost(String postTime);
}

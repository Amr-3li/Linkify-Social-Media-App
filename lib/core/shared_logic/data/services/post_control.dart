import 'package:linkify/Features/home/data/Models/comment_model.dart';

abstract class PostControl {
  Future<void> deletePost(String userId, String time);
  Future<void> updatePost(String description, String userId, String time);
  Future<void> addRemoveLike(String postTime, String userId);
  Future<void> addComment(String postTime, CommentModel comment);
  Future<void> removeComment(String postTime, CommentModel comment);
}

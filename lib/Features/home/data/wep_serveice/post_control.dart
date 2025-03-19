import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class PostControl {
  Future<void> deletePost(PostModel post);
  Future<void> updatePost(PostModel post);
}

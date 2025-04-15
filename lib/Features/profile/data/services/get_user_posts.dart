import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class GetUserPosts {
  Future<List<PostModel>> getUserPosts(String id);
}

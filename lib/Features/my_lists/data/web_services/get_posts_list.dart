import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class GetPostsList {
  Future<List<PostModel>> getSavedPostsList();
  Future<List<PostModel>> getLikedPostsList();
}

import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class AddPost {
  Future<void> addPost(PostModel post);
}

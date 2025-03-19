import 'package:linkify/Features/home/data/Models/post_model.dart';

abstract class PostServ {
  Future<void> addPost(PostModel post);
}

import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/web_services/get_posts_list.dart';

class GetPostsListImpl implements GetPostsList {
  @override
  Future<List<PostModel>> getLikedPostsList() {
    // TODO: implement getLikedPostsList
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getSavedPostsList() {
    // TODO: implement getSavedPostsList
    throw UnimplementedError();
  }
}

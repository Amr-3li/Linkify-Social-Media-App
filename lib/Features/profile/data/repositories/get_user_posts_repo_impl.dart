import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/profile/data/repositories/get_user_posts_repo.dart';
import 'package:linkify/Features/profile/data/services/get_user_posts.dart';
import 'package:linkify/core/errors/failures.dart';

class GetUserPostsRepoImpl implements GetUserPostsRepo {
  final GetUserPosts postServ;
  GetUserPostsRepoImpl(this.postServ);
  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts(String id) async {
    try {
      List<PostModel> posts = await postServ.getUserPosts(id);
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

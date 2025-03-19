import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:linkify/Features/home/data/wep_serveice/get_posts_serv.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

class GetPostsRepoImpl implements GetPostRepo {
  final GetPostsServ postServ;

  GetPostsRepoImpl(this.postServ);
  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    try {
      List<PostModel> posts = await postServ.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

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

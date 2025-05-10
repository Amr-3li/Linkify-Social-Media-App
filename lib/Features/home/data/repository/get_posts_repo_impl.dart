import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:linkify/Features/home/data/wep_serveice/get_posts_serv.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

class GetPostsRepoImpl implements GetPostRepo {
  final GetPostsServ postServ;

  GetPostsRepoImpl(this.postServ);

  @override
  Future<Either<Failure, List<PostModel>>> getMyTimelinePosts() async {
    try {
      List<PostModel> posts = await postServ.getMyTimelinePosts();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> refreshTimeline() async {
    try {
      List<PostModel> posts = await postServ.refreshTimeline();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments(
      String postTime) async {
    try {
      final response = await postServ.getComments(postTime);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LoverModel>>> getLoversPost(
      String postTime) async {
    try {
      final response = await postServ.getLoversPost(postTime);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> getPost(String postTime) async {
    try {
      final response = await postServ.getPost(postTime);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

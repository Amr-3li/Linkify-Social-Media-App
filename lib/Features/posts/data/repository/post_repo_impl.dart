import 'package:dartz/dartz.dart';
import 'package:linkify/Features/posts/data/model/post_model.dart';
import 'package:linkify/Features/posts/data/repository/post_repo.dart';
import 'package:linkify/Features/posts/data/services/post_serv.dart';
import 'package:linkify/core/errors/failures.dart';

class PostRepoImpl implements PostRepo {
  final PostServ postServ;

  PostRepoImpl(this.postServ);
  @override
  Future<Either<Failure, void>> addPost(PostModel post) async {
    try {
      await postServ.addPost(post);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(PostModel post) async {
    try {
      await postServ.deletePost(post);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

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

  @override
  Future<Either<Failure, void>> updatePost(PostModel post) async {
    try {
      await postServ.updatePost(post);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

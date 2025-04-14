import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/shared_logic/data/repositories/post_control_repo.dart';
import 'package:linkify/core/shared_logic/data/services/post_control.dart';
import 'package:linkify/core/errors/failures.dart';

class PostControlRepoImpl implements PostControlRepo {
  final PostControl postControl;

  PostControlRepoImpl(this.postControl);
  @override
  Future<Either<Failure, void>> deletePost(String userId, String time) async {
    try {
      await postControl.deletePost(userId, time);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(PostModel post) async {
    try {
      await postControl.updatePost(post);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComment(
      String postTime, CommentModel comment) async {
    try {
      await postControl.addComment(postTime, comment);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addRemoveLike(
      String postTime, String userId) async {
    try {
      await postControl.addRemoveLike(postTime, userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeComment(
      String postTime, CommentModel comment) async {
    try {
      await postControl.removeComment(postTime, comment);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

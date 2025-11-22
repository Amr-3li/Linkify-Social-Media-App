import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
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
  Future<Either<Failure, void>> updatePost(
      String description, String userId, String time) async {
    try {
      await postControl.updatePost(description, userId, time);
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
  Future<Either<Failure, void>> addRemoveLike(String postTime) async {
    try {
      await postControl.addRemoveLike(postTime);
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

  @override
  Future<Either<Failure, void>> saveAndUnSavePost(String postTime) async {
    try {
      await postControl.saveAndUnSavePost(postTime);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfPostLoved(String postTime) async {
    try {
      final isLoved = await postControl.checkIfPostLoved(postTime);
      return Right(isLoved);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfPostSaved(String postTime) async {
    try {
      final isSaved = await postControl.checkIfPostSaved(postTime);
      return Right(isSaved);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

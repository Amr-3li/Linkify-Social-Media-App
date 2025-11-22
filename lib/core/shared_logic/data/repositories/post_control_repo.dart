import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class PostControlRepo {
  Future<Either<Failure, void>> deletePost(String userId, String time);
  Future<Either<Failure, void>> updatePost(
      String description, String userId, String time);
  Future<Either<Failure, void>> addRemoveLike(String postTime);
  Future<Either<Failure, void>> addComment(
      String postTime, CommentModel comment);
  Future<Either<Failure, void>> removeComment(
      String postTime, CommentModel comment);
  Future<Either<Failure, void>> saveAndUnSavePost(String postTime);
  Future<Either<Failure, bool>> checkIfPostSaved(String postTime);
  Future<Either<Failure, bool>> checkIfPostLoved(String postTime);
}

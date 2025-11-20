import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class GetPostsListRepo {
  Future<Either<Failure, List<PostModel>>> getSavedPostsList();
  Future<Either<Failure, List<PostModel>>> getLikedPostsList();
  Future<Either<Failure, List<PostModel>>> refreshLikedPostsList();
  Future<Either<Failure, List<PostModel>>> refreshSavedPostsList();
}

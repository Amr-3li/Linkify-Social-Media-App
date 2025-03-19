import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class PostControlRepo {
  Future<Either<Failure, void>> deletePost(PostModel post);
  Future<Either<Failure, void>> updatePost(PostModel post);
}

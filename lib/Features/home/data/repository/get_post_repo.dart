import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class GetPostRepo {
  Future<Either<Failure, List<PostModel>>> getAllPosts();
  Future<Either<Failure, List<PostModel>>> getUserPosts(String id);
}

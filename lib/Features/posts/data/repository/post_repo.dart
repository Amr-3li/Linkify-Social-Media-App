import 'package:dartz/dartz.dart';
import 'package:linkify/Features/posts/data/model/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> addPost(PostModel post);
  Future<Either<Failure, void>> deletePost(PostModel post);
  Future<Either<Failure, void>> updatePost(PostModel post);
  Future<Either<Failure, List<PostModel>>> getAllPosts();
  Future<Either<Failure, List<PostModel>>> getUserPosts(String id);
}

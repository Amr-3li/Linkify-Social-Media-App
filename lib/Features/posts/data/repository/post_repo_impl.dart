import 'package:dartz/dartz.dart';
import 'package:linkify/Features/posts/data/model/post_model.dart';
import 'package:linkify/Features/posts/data/repository/post_repo.dart';
import 'package:linkify/core/errors/failures.dart';

class PostRepoImpl implements PostRepo {
  @override
  Future<Either<Failure, void>> addPost(PostModel post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deletePost(PostModel post) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts(String id) {
    // TODO: implement getUserPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}

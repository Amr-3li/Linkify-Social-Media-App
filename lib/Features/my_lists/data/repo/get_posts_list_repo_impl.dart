// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/repo/get_posts_list_repo.dart';
import 'package:linkify/Features/my_lists/data/web_services/get_posts_list.dart';
import 'package:linkify/core/errors/failures.dart';

class GetPostsListRepoImpl implements GetPostsListRepo {
  GetPostsList postsService;
  GetPostsListRepoImpl(this.postsService);
  @override
  Future<Either<Failure, List<PostModel>>> getLikedPostsList() async {
    try {
      final result = await postsService.getLikedPostsList();
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getSavedPostsList() async {
    try {
      final result = await postsService.getSavedPostsList();
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

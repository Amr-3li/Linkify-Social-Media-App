import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/repository/post_control_repo.dart';
import 'package:linkify/Features/home/data/wep_serveice/post_control.dart';
import 'package:linkify/core/errors/failures.dart';

class PostControlRepoImpl implements PostControlRepo {
  final PostControl postControl;

  PostControlRepoImpl(this.postControl);
  @override
  Future<Either<Failure, void>> deletePost(PostModel post) async {
    try {
      await postControl.deletePost(post);
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
}

import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class GetPostRepo {
  Future<Either<Failure, List<PostModel>>> getMyTimelinePosts();
  Future<Either<Failure, List<CommentModel>>> getComments(String postTime);
  Future<Either<Failure, List<LoverModel>>> getLoversPost(String postTime);
}

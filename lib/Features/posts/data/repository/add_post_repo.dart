import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> addPost(PostModel post);
}

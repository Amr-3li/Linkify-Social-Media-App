import 'package:dartz/dartz.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/posts/data/repository/add_post_repo.dart';
import 'package:linkify/Features/posts/data/services/post_serv.dart';
import 'package:linkify/core/errors/failures.dart';

class AddPostRepoImpl implements AddPostRepo {
  final AddPost postServ;

  AddPostRepoImpl(this.postServ);
  @override
  Future<Either<Failure, void>> addPost(PostModel post) async {
    try {
      await postServ.addPost(post);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

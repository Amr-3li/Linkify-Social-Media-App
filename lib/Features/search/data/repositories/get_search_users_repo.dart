import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class GetSearchUsersRepo {
  Future<Either<Failure, List<UserModel>>> getUsersBySearch(String search);
}

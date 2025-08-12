import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class ChatUsersRepo {
  Future<Either<Failure, List<UserModel>>> getChatUsers();
}

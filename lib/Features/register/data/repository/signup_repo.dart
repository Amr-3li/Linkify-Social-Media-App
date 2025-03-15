import 'package:dartz/dartz.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class SignupRepo {
  Future<Either<Failure, void>> signup(UserModel user);
}

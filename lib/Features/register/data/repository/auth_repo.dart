import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signin(String username, String password);
  Future<Either<Failure, void>> signout();
  Future<Either<Failure, void>> signInWithGoogle();
}

import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signin(String username, String password);
  Future<Either<Failure, void>> signout();
  Future<Either<Failure, String>> signInWithGoogle();
}

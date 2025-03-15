import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class UserDataRepo {
  Future<Either<Failure, List<UserModel>>> getAllUsers();
  Future<Either<Failure, UserModel>> getUserById(String id);
  Future<Either<Failure, List<UserModel>>> getUsersBySearch(String search);
  Future<Either<Failure, List<UserModel>>> getUsersFrind(String id);
  Future<Either<Failure, void>> updateUser(UserModel user);
  Future<Either<Failure, void>> deleteUser();
}

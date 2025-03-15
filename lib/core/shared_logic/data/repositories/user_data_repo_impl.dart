import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

class UserDataRepoImpl extends UserDataRepo {
  @override
  Future<Either<Failure, void>> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersBySearch(String search) {
    // TODO: implement getUsersBySearch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersFrind(String id) {
    // TODO: implement getUsersFrind
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}

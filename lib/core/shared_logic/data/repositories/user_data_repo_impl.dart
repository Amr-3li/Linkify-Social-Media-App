import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';
import 'package:linkify/core/shared_logic/data/services/users_data.dart';

class UserDataRepoImpl extends UserDataRepo {
  final UsersData usersData;

  UserDataRepoImpl(this.usersData);

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      await usersData.deleteUser();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("failed to delete user"));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final users = await usersData.getAllUsers();
      return Right(users);
    } catch (e) {
      return Left(ServerFailure("failed to get users"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(String id) async {
    try {
      final user = await usersData.getUserById(id);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure("failed to get user"));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersBySearch(
      String search) async {
    try {
      List<UserModel> users = await usersData.getUsersBySearch(search);
      return Right(users);
    } catch (e) {
      return Left(ServerFailure("failed to get users"));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsersFrind(String id) {
    // TODO: implement getUsersFrind
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateUser(UserModel user) async {
    try {
      await usersData.updateUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("failed to update user"));
    }
  }
}

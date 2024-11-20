import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser.dart';
import 'package:true_gym/core/errors/failures.dart';

class AuthRepoImpelement implements AuthRepository {
  final AuthService authservice;

  AuthRepoImpelement(this.authservice);
  @override
  Future<Either<Failure, String>> signin(
      String username, String password) async {
    try {
      String id = await authservice.signin(username, password);
      return Right(id);
    } catch (e) {
      return Left(ServerFailure("failed to signin"));
    }
  }

  @override
  Future<Either<Failure, void>> signout() async {
    try {
      await authservice.signout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("failed to signout"));
    }
  }
}

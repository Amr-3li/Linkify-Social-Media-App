import 'package:dartz/dartz.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/register/data/repository/signup_repo.dart';
import 'package:linkify/Features/register/data/web_servecies/signup_ser.dart';
import 'package:linkify/core/errors/failures.dart';

class SignupRepoImplement implements SignupRepo {
  final SignupService signupService;

  SignupRepoImplement(this.signupService);
  @override
  Future<Either<Failure, void>> signup(UserModel user) async {
    try {
      await signupService.register(user);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("failed to signup"));
    }
  }
}

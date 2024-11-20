import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo.dart';
import 'package:true_gym/Features/register/data/web_servecies/signup_ser.dart';
import 'package:true_gym/core/errors/failures.dart';

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

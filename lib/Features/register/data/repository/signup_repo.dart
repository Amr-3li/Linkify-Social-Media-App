import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/errors/failures.dart';

abstract class SignupRepo {
  Future<Either<Failure, void>> signup(UserModel user);
}

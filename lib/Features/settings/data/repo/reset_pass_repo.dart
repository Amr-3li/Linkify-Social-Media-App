import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class ResetPassRepo {
  Future<Either<Failure, void>> resetPass(
      {required String oldPass, required String newPass});
}

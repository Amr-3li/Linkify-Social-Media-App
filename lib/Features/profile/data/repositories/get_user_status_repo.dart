import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class GetUserStatusRepo {
  Future<Either<Failure, String>> userStatus(String toId);
}

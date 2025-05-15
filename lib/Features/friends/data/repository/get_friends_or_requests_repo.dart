import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class GetFriendsOrRequestsRepo {
  Future<Either<Failure, List<UserModel>>> getUserFrinds();
  Future<Either<Failure, List<UserModel>>> initialUserFrinds();
  Future<Either<Failure, List<UserModel>>> getYourRequests();
  Future<Either<Failure, List<UserModel>>> initialYourRequests();
  Future<Either<Failure, List<UserModel>>> getFriendRequests();
  Future<Either<Failure, List<UserModel>>> initialFriendRequests();
}

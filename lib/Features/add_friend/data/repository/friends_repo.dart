import 'package:dartz/dartz.dart';
import 'package:linkify/core/errors/failures.dart';

abstract class FriendsRepo {
  Future<Either<Failure, void>> sendFriendRequest(String toId);
  Future<Either<Failure, void>> unSendFriendRequest(String toId);
  Future<Either<Failure, void>> rejectFriendRequest(String fromId);
  Future<Either<Failure, void>> acceptFriendRequest(String fromId);
}

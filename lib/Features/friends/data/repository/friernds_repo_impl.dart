import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/friends/data/repository/friends_repo.dart';
import 'package:linkify/Features/friends/data/service/friend_serv.dart';
import 'package:linkify/core/errors/failures.dart';

class FrierndsRepoImpl implements FriendsRepo {
  final FriendServ services;

  FrierndsRepoImpl(this.services);
  @override
  Future<Either<Failure, void>> acceptFriendRequest(String fromId) async {
    try {
      await services.acceptFriendRequest(fromId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectFriendRequest(String fromId) async {
    try {
      await services.rejectFriendRequest(fromId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest(String toId) async {
    try {
      await services.sendFriendRequest(toId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unSendFriendRequest(String toId) async {
    try {
      await services.unSendFriendRequest(toId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFriend(String toId) async {
    try {
      await services.removeFriend(toId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:linkify/Features/friends/data/repository/get_friends_or_requests_repo.dart';
import 'package:linkify/Features/friends/data/service/get_friends_or_requests.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class GetFriendsOrRequestsRepoImpl implements GetFriendsOrRequestsRepo {
  final GetFriendsOrRequests services;

  GetFriendsOrRequestsRepoImpl(this.services);
  @override
  Future<Either<Failure, List<UserModel>>> getFriendRequests() async {
    try {
      final response = await services.getFriendRequests();
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUserFrinds() async {
    try {
      final response = await services.getUserFrinds();
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getYourRequests() async {
    try {
      final response = await services.getYourRequests();
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}

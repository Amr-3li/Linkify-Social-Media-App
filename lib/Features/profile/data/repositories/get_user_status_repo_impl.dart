import 'package:dartz/dartz.dart';
import 'package:linkify/Features/profile/data/repositories/get_user_status_repo.dart';
import 'package:linkify/Features/profile/data/services/get_user_status.dart';
import 'package:linkify/core/errors/failures.dart';

class GetUserStatusRepoImpl implements GetUserStatusRepo {
  final GetUserStatus service;

  GetUserStatusRepoImpl(this.service);

  @override
  Future<Either<Failure, String>> userStatus(String toId) async {
    try {
      final response = await service.userStatus(toId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

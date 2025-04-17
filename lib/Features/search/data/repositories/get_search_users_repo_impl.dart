import 'package:dartz/dartz.dart';
import 'package:linkify/Features/search/data/repositories/get_search_users_repo.dart';
import 'package:linkify/Features/search/data/services/get_search_users.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class GetSearchUsersRepoImpl implements GetSearchUsersRepo {
  final GetSearchUsers getSearchUser;

  GetSearchUsersRepoImpl(this.getSearchUser);

  @override
  Future<Either<Failure, List<UserModel>>> getUsersBySearch(
      String search) async {
    try {
      final response = await getSearchUser.getUsersBySearch(search);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

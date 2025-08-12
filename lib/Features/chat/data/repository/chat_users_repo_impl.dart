import 'package:dartz/dartz.dart';
import 'package:linkify/Features/chat/data/repository/chat_users_repo.dart';
import 'package:linkify/Features/chat/data/web_services/chat_users.dart';
import 'package:linkify/core/errors/failures.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class ChatUsersRepoImpl implements ChatUsersRepo {
  final ChatUsers chatUsers;

  ChatUsersRepoImpl(this.chatUsers);
  @override
  Future<Either<Failure, List<UserModel>>> getChatUsers() async {
    try {
      final response = await chatUsers.getChatUsers();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

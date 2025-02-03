import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/chat/data/web_services/chat_ser.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/errors/failures.dart';

class ChatRepoImplementation extends ChatRepo {
  final ChatSer chatSer;

  ChatRepoImplementation(this.chatSer);
  @override
  Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>> getAllMessage(
      UserModel toUser) {
    try {
      final response = chatSer.getAllMessage(toUser);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure("Failuer in get all message "));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      UserModel toUser, String msg) async {
    try {
      await chatSer.sendMessage(toUser, msg);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failuer in send message "));
    }
  }
}

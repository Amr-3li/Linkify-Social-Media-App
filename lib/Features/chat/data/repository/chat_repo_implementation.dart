import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo.dart';
import 'package:linkify/Features/chat/data/web_services/chat_ser.dart';
import 'package:linkify/core/errors/failures.dart';

class ChatRepoImplementation extends ChatRepo {
  final ChatSer chatSer;

  ChatRepoImplementation(this.chatSer);
  @override
  Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>> getAllMessage(
      String toId) {
    try {
      final response = chatSer.getAllMessage(toId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure("Failuer in get all message "));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      String toId, String imageURL, String record, String msg) async {
    try {
      await chatSer.sendMessage(toId, imageURL, record, msg);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failuer in send message "));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      countUnreadMessage(String toId) async {
    try {
      final result = await chatSer.countUnreadMessage(toId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure("Failuer in send message "));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:true_gym/core/errors/failures.dart';

abstract class ChatRepo {
  Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>> getAllMessage(
      String toId);
  Future<Either<Failure, void>> sendMessage(
      String toId, bool isImage, String msg);
}

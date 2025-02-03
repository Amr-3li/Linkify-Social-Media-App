import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/core/errors/failures.dart';

abstract class ChatRepo {
  Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>> getAllMessage(
      UserModel toUser);
  Future<Either<Failure, void>> sendMessage(UserModel toUser, String msg);
}

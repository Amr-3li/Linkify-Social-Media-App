import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class ChatUsers {
  Future<List<UserModel>> getChatUsers();
}

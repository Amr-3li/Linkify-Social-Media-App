import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class AddFriendServ {
  Future<List<UserModel>> getUserFrinds(String id);
  Future<List<UserModel>> getUserRequests(String id);

  Future<void> sendFriendRequest(String fromId, String toId);
  Future<void> unSendFriendRequest(String fromId, String toId);
}

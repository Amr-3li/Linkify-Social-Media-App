import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class AddFriendServ {
  Future<List<UserModel>> getUserFrinds();
  Future<List<UserModel>> getYourRequests();
  Future<List<UserModel>> getFriendRequests();

  Future<void> sendFriendRequest(String fromId, String toId);
  Future<void> unSendFriendRequest(String fromId, String toId);
}

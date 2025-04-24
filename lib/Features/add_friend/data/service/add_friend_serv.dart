import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class AddFriendServ {
  Future<void> sendFriendRequest(String fromId, String toId);
  Future<void> unSendFriendRequest(String fromId, String toId);
}

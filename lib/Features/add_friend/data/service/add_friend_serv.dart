import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class AddFriendServ {
  Future<void> sendFriendRequest(String toId);
  Future<void> unSendFriendRequest(String toId);
}

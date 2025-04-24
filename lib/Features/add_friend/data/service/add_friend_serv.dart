abstract class AddFriendServ {
  Future<void> sendFriendRequest(String toId);
  Future<void> unSendFriendRequest(String toId);
  Future<void> rejectFriendRequest(String fromId);
  Future<void> acceptFriendRequest(String fromId);
}

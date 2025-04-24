import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class GetFriendsOrRequests {
  Future<List<UserModel>> getUserFrinds();
  Future<List<UserModel>> getYourRequests();
  Future<List<UserModel>> getFriendRequests();
}

import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class GetFriendsOrRequests {
  Future<List<UserModel>> getUserFrinds();
  Future<List<UserModel>> initialUserFrinds();
  Future<List<UserModel>> getYourRequests();
  Future<List<UserModel>> initialYourRequests();
  Future<List<UserModel>> getFriendRequests();
  Future<List<UserModel>> initialFriendRequests();
}

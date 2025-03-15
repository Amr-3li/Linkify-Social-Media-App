import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class UsersData {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUserById(String id);
  Future<List<UserModel>> getUsersBySearch(String search);
  Future<List<UserModel>> getUsersFrind(String id);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser();
}

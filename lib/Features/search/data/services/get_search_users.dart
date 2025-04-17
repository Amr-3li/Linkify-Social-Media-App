import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class GetSearchUsers {
  Future<List<UserModel>> getUsersBySearch(String search);
}

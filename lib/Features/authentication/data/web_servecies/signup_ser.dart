import 'package:linkify/core/shared_logic/data/models/user.dart';

abstract class SignupService {
  Future<void> register(UserModel user);
}

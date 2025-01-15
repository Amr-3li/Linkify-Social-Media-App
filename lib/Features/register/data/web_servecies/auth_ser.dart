import 'package:true_gym/Features/register/data/model/user.dart';

abstract class AuthService {
  Future<String> signin(String username, String password);
  Future<void> signout();
  Future<void> signinWithGoogle();
}

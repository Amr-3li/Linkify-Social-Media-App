import 'package:true_gym/Features/register/data/web_servecies/auth.dart';

class AuthRepository {
  final AuthWebservice _authWebservice;
  AuthRepository(this._authWebservice);

  Future<void> signin(String username, String password) async {
     await _authWebservice.signin(username, password);
  }

  Future<bool> register(String username, String password) async {
    return await _authWebservice.register(username, password);
  }

  Future<bool> signout() async {
    return await _authWebservice.signout();
  }
}

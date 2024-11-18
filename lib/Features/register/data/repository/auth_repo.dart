import 'package:true_gym/Features/register/data/web_servecies/auth_ser_imp.dart';

class AuthRepository {
  final AuthWebServiceImplement _authWebservice;
  AuthRepository(this._authWebservice);

  Future<void> signin(String username, String password) async {
    await _authWebservice.signin(username, password);
  }

  Future<bool> signout() async {
    return await _authWebservice.signout();
  }
}

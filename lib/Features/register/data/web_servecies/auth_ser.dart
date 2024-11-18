abstract class AuthService {
  Future<void> signin(String username, String password);
  Future<bool> signout();
}

abstract class AuthService {
  Future<void> signin(String username, String password);
  Future<void> signout();
}

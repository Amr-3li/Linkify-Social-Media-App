abstract class AuthService {
  Future<String> signin(String username, String password);
  Future<void> signout();
  Future<void> signinWithGoogle();
}

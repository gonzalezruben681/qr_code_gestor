abstract class AuthRepository {
  Future<bool> loginUser(String email, String password);
  Future<void> registerUser(String nombre, String email, String password);
  Future<void> logoutUser();
  Future<bool> isUserLoggedIn();
  Future<String?> sendResetPasswordLink(String email);
}

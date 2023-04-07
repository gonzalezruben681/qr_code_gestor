abstract class AuthRepository {
  Future<String?> loginUser(String email, String password);
  Future<void> registerUser(String nombre, String email, String password);
  Future<void> logoutUser();
  Future<bool> isUserLoggedIn();
}

abstract class AuthRepository {
  Future<String?> authenticate(String email, String password);
  Future<void> register(String nombre, String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
}

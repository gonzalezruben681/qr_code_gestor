import 'package:qr_code_gestor/domain/repositories/auth_repository.dart';

class AuthenticationUseCase {
  final AuthRepository authenticationRepository;

  AuthenticationUseCase({required this.authenticationRepository});

  Future<bool> loginUser(String email, String password) async {
    return await authenticationRepository.loginUser(email, password);
  }

  Future<void> registerUser(
      String nombre, String email, String password) async {
    return await authenticationRepository.registerUser(nombre, email, password);
  }

  Future<void> logoutUser() async {
    return await authenticationRepository.logoutUser();
  }

  Future<bool> isUserLoggedIn() async {
    return await authenticationRepository.isUserLoggedIn();
  }
}

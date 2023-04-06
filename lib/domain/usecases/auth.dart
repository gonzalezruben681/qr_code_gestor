import 'package:qr_code_gestor/domain/repositories/auth_repository.dart';

class AuthenticationUseCase {
  final AuthRepository authenticationRepository;

  AuthenticationUseCase({required this.authenticationRepository});

  Future<String?> authenticate(String email, String password) async {
    return await authenticationRepository.authenticate(email, password);
  }

  Future<void> register(String nombre, String email, String password) async {
    return await authenticationRepository.register(nombre, email, password);
  }

  Future<void> signOut() async {
    return await authenticationRepository.signOut();
  }

  Future<bool> isSignedIn() async {
    return await authenticationRepository.isSignedIn();
  }
}

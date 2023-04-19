import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_gestor/data/firebase/repositories/auth_repository_impl.dart';
import 'package:qr_code_gestor/domain/usecases/auth_usecase.dart';

// Injeccion de dependencias
final firebaseAuthProvider = Provider<AuthenticationUseCase>((ref) =>
    AuthenticationUseCase(authenticationRepository: AuthRepositoryImpl()));

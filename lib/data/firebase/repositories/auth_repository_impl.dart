import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_gestor/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepositoryImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<String?> authenticate(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.credential?.accessToken;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<void> register(String nombre, String email, String password) async {
    // crear usuario
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    // agregar detalle del usuario
    final userCollection = firestore.collection('users');
    await userCollection.add({
      'name': nombre,
      'email': email,
    });
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}

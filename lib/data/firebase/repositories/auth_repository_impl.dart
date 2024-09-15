import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_code_gestor/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create storage
  final _storage = const FlutterSecureStorage();

  @override
  Future<bool> loginUser(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final token = await userCredential.user?.getIdToken();
      await _storage.write(key: 'token', value: token);
      return true;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> registerUser(
      String nombre, String email, String password) async {
    // crear usuario
    final userNewCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final token = await userNewCredential.user?.getIdToken();
    await _storage.write(key: 'token', value: token);
    // agregar detalle del usuario
    final userCollection = _firestore.collection('users');
    await userCollection.add({
      'name': nombre,
      'email': email,
    });
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      String token = await _getToken();
      return token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<String> _getToken() async {
    String? token = await _storage.read(key: 'token');
    if (token == null) {
      final user = _auth.currentUser;
      if (user != null) {
        final tokenResult = await user.getIdTokenResult();
        token = tokenResult.token;
        await _storage.write(key: 'token', value: token);
      }
    }
    return token ?? '';
  }

  @override
  Future<void> logoutUser() async {
    await _auth.signOut();
    await _storage.delete(key: 'token');
  }

  @override
  Future<String?> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // UserModel getCurrentUser() {
  //   final currentUser = _auth.currentUser;
  //   if (currentUser != null) {
  //     return UserModel(
  //         id: currentUser.uid, name: currentUser, email: currentUser.email!);
  //   } else {
  //     throw Exception('User not logged in');
  //   }
  // }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> userRegister({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'email-already-in-use') {
        log('Este usuario já está cadastrado.', error: e, stackTrace: s);
        return 'Este usuario já está cadastrado.';
      }
      return 'Erro desconhecido.';
    }
  }

  Future<String?> loadUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // metodo para deslogar o usuario
  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }
}

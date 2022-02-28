import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopper_app/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository;

  String _message = "";

  AuthProvider({required this.authRepository});

  String get message => _message;

  User? get currentUser => authRepository.getCurrentUser();

  bool get isLoggedIn => authRepository.isSignedIn();

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  Future<bool> loginUser({required String email, required String password}) async {
    try {
      final user = await authRepository.signInWithEmailAndPassword(email, password);
      if (user != null) {
        setMessage('Login Successful');
      } else {
        setMessage('Login Failed');
      }
      return user != null;
    } catch (e) {
      setMessage('$e');
      return false;
    }
  }

  Future<bool> logUserOut() async {
    await authRepository.signOut();
    return true;
  }

  Future<bool> sendPasswordResetLink({required String email}) async {
    try {
      await authRepository.sendPasswordResetEmail(email);
      setMessage('See your soon!');
      return true;
    } catch (e) {
      setMessage('$e');
      return false;
    }
  }
}

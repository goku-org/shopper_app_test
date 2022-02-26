import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopper_app/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  String _message = "";
  final AuthRepository _authRepository = GetIt.instance<AuthRepositoryImpl>();

  String get message => _message;

  User? get currentUser => _authRepository.getCurrentUser();

  bool get isLoggedIn => _authRepository.isSignedIn();

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  Future<bool> loginUser({required String email, required String password}) async {
    try {
      final user = await _authRepository.signInWithEmailAndPassword(email, password);
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
    await _authRepository.signOut();
    return true;
  }

  Future<bool> sendPasswordResetLink({required String email}) async {
    try {
      await _authRepository.sendPasswordResetEmail(email);
      setMessage('See your soon!');
      return true;
    } catch (e) {
      setMessage('$e');
      return false;
    }
  }
}

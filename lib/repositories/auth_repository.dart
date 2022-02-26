import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopper_app/config/config.dart';

abstract class AuthRepository {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  bool isSignedIn();
  User? getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  User? getCurrentUser() {
    return Config.firebaseAuth.currentUser;
  }

  @override
  bool isSignedIn() {
    final user = Config.firebaseAuth.currentUser;

    return user != null;
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final userCredential =
        await Config.firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    return await Config.firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return await Config.firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

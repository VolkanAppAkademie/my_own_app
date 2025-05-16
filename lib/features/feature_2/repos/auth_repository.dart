import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String?> signInWithEmailPassword(String email, String password);
  Future<String?> registerWithEmailPassword(String email, String password);
  Future<void> logOut();
  Stream<User?> onAuthChanged();
}

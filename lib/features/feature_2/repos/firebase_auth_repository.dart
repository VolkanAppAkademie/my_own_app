import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepository(this._auth);

  // Ausloggen (auch für Google, falls verwendet wird)
  @override
  Future<void> logOut() async {
    await _auth.signOut();
  }

  // Steuert den Kontrollfluss, ob ein User angemeldet ist oder nicht
  @override
  Stream<User?> onAuthChanged() => _auth.authStateChanges();

  // Nutzer mit E-Mail und Passwort registrieren
  @override
  Future<String?> registerWithEmailPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return "Diese E-Mail-Adresse wird bereits verwendet.";
        case 'invalid-email':
          return "Die eingegebene E-Mail-Adresse ist ungültig.";
        case 'weak-password':
          return "Das Passwort ist zu schwach. Bitte wählen Sie ein stärkeres Passwort.";
        case 'operation-not-allowed':
          return "Die Registrierung mit E-Mail und Passwort ist derzeit nicht aktiviert.";
        default:
          return "Ein unbekannter Fehler ist aufgetreten: ${e.message}";
      }
    }
    return null;
  }

  // Nutzer mit E-Mail und Passwort einloggen
  @override
  Future<String?> signInWithEmailPassword(String email, String password) async {
    try {
      // Authentifizierungsmethode aufrufen
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Authentifizierungsfehler abfangen
      print('email: $email, passwort: $password');
      switch (e.code) {
        case 'invalid-email':
          return "Die E-Mail-Adresse ist ungültig.";
        case 'user-disabled':
          return "Dieses Benutzerkonto wurde deaktiviert.";
        case 'user-not-found':
          return "Kein Benutzer gefunden. Bitte registrieren Sie sich.";
        case 'wrong-password':
          return "Falsches Passwort. Bitte versuchen Sie es erneut.";
        case 'too-many-requests':
          return "Zu viele fehlgeschlagene Anmeldeversuche. Bitte versuchen Sie es später erneut.";
        default:
          return "Ein unbekannter Fehler ist aufgetreten: ${e.message}";
      }
    }
    return null;
  }
}

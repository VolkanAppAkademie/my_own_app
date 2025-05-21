import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/shared/models/transaction.dart';

class BudgetProvider extends ChangeNotifier {
  late FirebaseAuth auth;
  late FirebaseAuthRepository authRepository;
  BudgetProvider() {
    auth = FirebaseAuth.instance;
    authRepository = FirebaseAuthRepository(auth);
  }
}

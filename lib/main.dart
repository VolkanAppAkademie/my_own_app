import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/app/app.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/firebase_options.dart';
import 'package:my_own_app/shared/repos/database_repository.dart';
import 'package:my_own_app/shared/repos/mock_database.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseRepository databaseRepository = MockDatabaseRepository();
  final AuthRepository authRepository = FirebaseAuthRepository(auth);

  final TransactionController transactionController =
      TransactionController(databaseRepository);

  runApp(MyApp(
      transactionController: transactionController,
      authRepository: authRepository));
}


//Provider implementieren 
//initialisieren
//Auth Repo (Firebase)in Provider packen
// Logout implementieren

// AuthProvider  in main initialisieren
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/app/app.dart';
import 'package:my_own_app/budget_provider.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/firebase_options.dart';
import 'package:my_own_app/shared/repos/database_repository.dart';
import 'package:my_own_app/shared/repos/firestore_transaction_repo.dart';
import 'package:my_own_app/shared/repos/mock_database.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:my_own_app/transaction_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DatabaseRepository databaseRepository = MockDatabaseRepository();

  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestoreInstanz = FirebaseFirestore.instance;

  final FirestoreTransactionRepo firestoreTransactionRepo =
      FirestoreTransactionRepo(firestore: firestoreInstanz, auth: auth);

  FirebaseAuthRepository authRepository = FirebaseAuthRepository(auth);

  runApp(MultiProvider(
    providers: [
      Provider<FirebaseAuthRepository>(create: (_) => authRepository),
      ChangeNotifierProvider(create: (_) {
        final TransactionProvider habitProvider = TransactionProvider(
            firestoreTransactionRepo: firestoreTransactionRepo);
        //    Der Aufruf hier ist "fire-and-forget" (wir warten nicht mit `await` darauf),
        //    weil `create` synchron sein muss. Der Provider selbst kümmert sich
        //    intern darum, seinen Ladezustand (`loading`) zu verwalten und die
        //    UI via `notifyListeners()` zu informieren.
        habitProvider.initialize();
        return habitProvider;
      }),
    ],
    child: MyApp(),
  ));
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/budget_provider.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/authentication/screens/login_page_firebase.dart';
import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseAuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    authRepository =
        Provider.of<FirebaseAuthRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authRepository.onAuthChanged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final isLoggedIn = snapshot.hasData;

        return MaterialApp(
          key: ValueKey(isLoggedIn ? "logged_in" : "not_logged_in"),
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: isLoggedIn ? HomeArea() : LoginScreen(),
        );
      },
    );
  }
}

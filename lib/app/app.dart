import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/authentication/screens/login_page.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class MyApp extends StatelessWidget {
  final TransactionController transactionController;

  MyApp({required this.transactionController, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: LoginPage(transactionController: transactionController),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/budget_home_screen.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class MyApp extends StatelessWidget {
  final TransactionController transactionController;

  MyApp({required this.transactionController, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BudgetHomeScreen(
        transactionController: transactionController,
      ),
    );
  }
}

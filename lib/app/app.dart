import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/BudgetHomeScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BudgetHomeScreen(),
    );
  }
}

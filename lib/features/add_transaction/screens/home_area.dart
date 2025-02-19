import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/budget_home_screen.dart';
import 'package:my_own_app/features/add_transaction/screens/expense_screen.dart';
import 'package:my_own_app/features/add_transaction/screens/income_screen.dart';
import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class HomeArea extends StatefulWidget {
  final TransactionController transactionController;
  const HomeArea({required this.transactionController, super.key});

  @override
  State<HomeArea> createState() => _HomeAreaState();
}

class _HomeAreaState extends State<HomeArea> {
  int selectedArea = 1;
  List<String> appBarTexts = ['Einnahmen', 'Übersicht', 'Ausgaben'];
  //final List<Transaction> _transactions = [];
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _addTransaction() {
    var amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text;

    if (amount != null && description.isNotEmpty) {
      setState(() {
        if (amount < 0) {
          //_transactions.add(Transaction(amount, description, 'Ausgabe'));
          widget.transactionController
              .addTransaction("2", Transaction(amount, description, 'Ausgabe'));
        } else {
          //_transactions.add(Transaction(amount, description, 'Einnahme'));
          widget.transactionController.addTransaction(
              "3", Transaction(amount, description, 'Einnahme'));
        }
      });

      _amountController.clear();
      _descriptionController.clear();
    }
  }

  Widget switchBody() {
    switch (selectedArea) {
      case 0:
        return IncomeScreen(
          transactionController: widget.transactionController,
        );
      case 1:
        return BudgetHomeScreen(
          transactionController: widget.transactionController,
          amountController: _amountController,
          descriptionController: _descriptionController,
          addTransaction: _addTransaction,
        );
      case 2:
        return ExpenseScreen(
            transactionController: widget.transactionController);
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTexts[selectedArea]),
        backgroundColor: Colors.teal,
      ),
      body: switchBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedArea,
        onTap: (index) => setState(() => selectedArea = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Einnahmen',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Startseite'),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            label: 'Ausgaben',
          ),
        ],
      ),
    );
  }
}

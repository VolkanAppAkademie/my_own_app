import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/budget_home_screen.dart';
import 'package:my_own_app/features/add_transaction/screens/expense_screen.dart';
import 'package:my_own_app/features/add_transaction/screens/income_screen.dart';
import 'package:my_own_app/shared/models/transaction.dart';

class HomeArea extends StatefulWidget {
  const HomeArea({super.key});

  @override
  State<HomeArea> createState() => _HomeAreaState();
}

class _HomeAreaState extends State<HomeArea> {
  int selectedArea = 1;
  List<String> appBarTexts = ['Einnahmen', 'Übersicht', 'Ausgaben'];
  final List<Transaction> _transactions = [];
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Berechnung der Gesamteinnahmen
  double get _totalIncome {
    return _transactions
        .where((tx) => tx.amount > 0)
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  // Berechnung der Gesamtausgaben
  double get _totalExpenses {
    return _transactions
        .where((tx) => tx.amount < 0)
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  void _addTransaction() {
    var amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text;

    if (amount != null && description.isNotEmpty) {
      setState(() {
        if (amount < 0) {
          _transactions.add(Transaction(amount, description, 'Ausgabe'));
          //widget.transactionController.addTransaction("2", Transaction(amount, description, 'Ausgabe'));
        } else {
          _transactions.add(Transaction(amount, description, 'Einnahme'));
          //widget.transactionController.addTransaction("3", Transaction(amount, description, 'Einnahme'));
        }
      });

      _amountController.clear();
      _descriptionController.clear();
    }
  }

  Widget switchBody() {
    switch (selectedArea) {
      case 0:
        return IncomeScreen(transactions: _transactions);
      case 1:
        return BudgetHomeScreen(
          totalIncome: _totalIncome,
          totalExpenses: _totalExpenses,
          amountController: _amountController,
          descriptionController: _descriptionController,
          addTransaction: _addTransaction,
          transactions: _transactions,
        );
      case 2:
        return ExpenseScreen(transactions: _transactions);
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

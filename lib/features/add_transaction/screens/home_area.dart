import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/budget_provider.dart';
import 'package:my_own_app/features/add_transaction/screens/budget_home_screen.dart';
import 'package:my_own_app/features/add_transaction/screens/expense_screen.dart';
import 'package:my_own_app/features/add_transaction/screens/income_screen.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/main.dart';
import 'package:my_own_app/shared/models/transaction.dart' as my;
import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeArea extends StatefulWidget {
  final TransactionController transactionController;
  const HomeArea({required this.transactionController, super.key});

  @override
  State<HomeArea> createState() => _HomeAreaState();
}

class _HomeAreaState extends State<HomeArea> {
  int selectedArea = 1;
  List<String> appBarTexts = ['Einnahmen', 'Transaktionen', 'Ausgaben'];
  //final List<Transaction> _transactions = [];
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  late FirebaseAuthRepository authRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authRepository =
        Provider.of<BudgetProvider>(context, listen: false).authRepository;
  }

  void _addTransaction() {
    var amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text;
    /*try {
      FirebaseFirestore.instance.collection('transactions').add({
        'transaction': {
          'amount': amount,
          'description': description,
        }
      });
    } catch (e) {
      print('error:$e');
    }
*/
    //auf Firebase amount & description als ein Objekt schreiben

    FirebaseFirestore.instance.collection('transactions').add({
      'transaction': {
        'amount': amount,
        'description': description,
      }
    });

    if (amount != null && description.isNotEmpty) {
      setState(() {
        if (amount < 0) {
          //_transactions.add(Transaction(amount, description, 'Ausgabe'));
          widget.transactionController.addTransaction(
              "2", my.Transaction(amount, description, 'Ausgabe'));
        } else {
          //_transactions.add(Transaction(amount, description, 'Einnahme'));
          widget.transactionController.addTransaction(
              "3", my.Transaction(amount, description, 'Einnahme'));
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
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => authRepository.logOut(),
            icon: Icon(Icons.logout),
            tooltip: 'Abmelden',
          )
        ],
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
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Transaktionen',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            label: 'Ausgaben',
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/budget_provider.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:provider/provider.dart';
import 'package:my_own_app/shared/models/transaction.dart' as my;

class ExpenseScreen extends StatefulWidget {
  // Wir erhalten die Transaktionen, die auf dem Hauptscreen hinzugefügt wurden
  final TransactionController transactionController;

  const ExpenseScreen({super.key, required this.transactionController});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late FirebaseAuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    getTransactions();

    authRepository =
        Provider.of<BudgetProvider>(context, listen: false).authRepository;
  }

  void getTransactions() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('transactions').get();

    for (var doc in snapshot.docs) {
      final data = (doc.data() as Map<String, dynamic>);
      double amount =
          (data['transaction'] as Map<String, dynamic>)['amount'] ?? 0;
      String description =
          (data['transaction'] as Map<String, dynamic>)['description'] ?? '';

      widget.transactionController.addTransaction(
          doc.id, my.Transaction(amount, description, 'Ausgabe'));

      print('ID: ${doc.id}, Daten: ${doc.data()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.transactionController.getAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            final incomeTransactions =
                snapshot.data!.where((tx) => tx.amount < 0).toList();

            if (incomeTransactions.isEmpty) {
              return Center(child: Text('Keine Ausgaben'));
            }

            return ListView.builder(
              itemCount: incomeTransactions.length,
              itemBuilder: (ctx, index) {
                final tx = incomeTransactions[index];
                return ListTile(
                  title: Text(tx.description),
                  subtitle: Text('€${tx.amount.toStringAsFixed(2)}'),
                  leading: Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

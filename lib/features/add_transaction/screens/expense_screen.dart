import 'package:flutter/material.dart';
import 'package:my_own_app/shared/models/transaction.dart';

class ExpenseScreen extends StatelessWidget {
  final List<Transaction> transactions;

  // Wir erhalten die Transaktionen, die auf dem Hauptscreen hinzugefügt wurden
  const ExpenseScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Filtern der Ausgaben
    final expenseTransactions =
        transactions.where((tx) => tx.amount < 0).toList();

    return expenseTransactions.isEmpty
        ? Center(child: Text("Keine Ausgaben verfügbar."))
        : ListView.builder(
            itemCount: expenseTransactions.length,
            itemBuilder: (ctx, index) {
              final tx = expenseTransactions[index];
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
  }
}

import 'package:flutter/material.dart';
import 'package:my_own_app/shared/models/transaction.dart';

class IncomeScreen extends StatelessWidget {
  final List<Transaction> transactions;

  // Wir erhalten die Transaktionen, die auf dem Hauptscreen hinzugefügt wurden
  const IncomeScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Filtern der Einnahmen
    final incomeTransactions =
        transactions.where((tx) => tx.amount > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Einnahmen'),
        backgroundColor: Colors.teal,
      ),
      body: incomeTransactions.isEmpty
          ? Center(child: Text("Keine Einnahmen verfügbar."))
          : ListView.builder(
              itemCount: incomeTransactions.length,
              itemBuilder: (ctx, index) {
                final tx = incomeTransactions[index];
                return ListTile(
                  title: Text(tx.description),
                  subtitle: Text('€${tx.amount.toStringAsFixed(2)}'),
                  leading: Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                );
              },
            ),
    );
  }
}

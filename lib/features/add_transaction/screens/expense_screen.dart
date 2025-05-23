import 'package:flutter/material.dart';
import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class ExpenseScreen extends StatelessWidget {
  // Wir erhalten die Transaktionen, die auf dem Hauptscreen hinzugefügt wurden
  final TransactionController transactionController;

  const ExpenseScreen({super.key, required this.transactionController});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: transactionController.getAllTransactions(),
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

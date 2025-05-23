import 'package:flutter/material.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class IncomeScreen extends StatelessWidget {
  //final List<Transaction> transactions;
  final TransactionController transactionController;

  // Wir erhalten die Transaktionen, die auf dem Hauptscreen hinzugefügt wurden
  const IncomeScreen({super.key, required this.transactionController});

  @override
  Widget build(BuildContext context) {
    // Filtern der Einnahmen
    //final incomeTransactions = transactions.where((tx) => tx.amount > 0).toList();

    return FutureBuilder(
        future: transactionController.getAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            final incomeTransactions =
                snapshot.data!.where((tx) => tx.amount > 0).toList();

            if (incomeTransactions.isEmpty) {
              return Center(child: Text('Keine Einnahmen'));
            }

            return ListView.builder(
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

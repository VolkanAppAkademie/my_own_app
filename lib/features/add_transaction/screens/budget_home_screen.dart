import 'package:flutter/material.dart';
import 'package:my_own_app/shared/models/transaction.dart';
// import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:my_own_app/shared/widgets/transaction_summary.dart';

class BudgetHomeScreen extends StatefulWidget {
  // final TransactionController transactionController;
  final double totalIncome;
  final double totalExpenses;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final VoidCallback addTransaction;
  final List<Transaction> transactions;

  const BudgetHomeScreen({
    // required this.transactionController,
    required this.totalIncome,
    required this.totalExpenses,
    required this.amountController,
    required this.descriptionController,
    required this.addTransaction,
    required this.transactions,
    super.key,
  });

  @override
  _BudgetHomeScreenState createState() => _BudgetHomeScreenState();
}

class _BudgetHomeScreenState extends State<BudgetHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Anzeige der Gesamteinnahmen und -ausgaben oben
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TransactionSummary(
                  label: 'Einnahmen',
                  amount: widget.totalIncome,
                  color: Colors.green,
                  icon: Icons.arrow_upward),
              TransactionSummary(
                  label: 'Ausgaben',
                  amount: widget.totalExpenses,
                  color: Colors.red,
                  icon: Icons.arrow_downward),
            ],
          ),
          SizedBox(height: 20),
          // Eingabefelder für neue Transaktionen
          TextField(
            controller: widget.amountController,
            decoration: InputDecoration(
              labelText: 'Betrag',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 10),
          TextField(
            controller: widget.descriptionController,
            decoration: InputDecoration(
              labelText: 'Beschreibung',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: widget.addTransaction,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            child: const Text('Transaktion hinzufügen'),
          ),
          SizedBox(height: 20),
          // Anzeige aller Transaktionen (Einnahmen + Ausgaben)
          Expanded(
            child: ListView.builder(
              itemCount: widget.transactions.length,
              itemBuilder: (ctx, index) {
                final tx = widget.transactions[index];
                return ListTile(
                  title: Text(tx.description),
                  subtitle: Row(
                    children: [
                      Text(
                        '€${tx.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: tx.amount > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        tx.type,
                        style: TextStyle(
                          color: tx.amount > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    tx.amount > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                    color: tx.amount > 0 ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

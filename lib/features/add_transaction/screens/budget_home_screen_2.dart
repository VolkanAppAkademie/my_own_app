import 'package:flutter/material.dart';
import 'package:my_own_app/shared/widgets/transaction_summary.dart';
import 'package:my_own_app/transaction_provider.dart';
import 'package:provider/provider.dart';

class BudgetHomeScreen extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController descriptionController;

  const BudgetHomeScreen({
    required this.amountController,
    required this.descriptionController,
    super.key,
  });

  @override
  _BudgetHomeScreenState createState() => _BudgetHomeScreenState();
}

class _BudgetHomeScreenState extends State<BudgetHomeScreen> {
  void _checkBudgetStatus(double totalIncome, double totalExpense) {
    final balance = totalIncome + totalExpense; // Ausgaben sind negativ

    String message;
    Color color;

    if (balance > 0) {
      message = '✅ Du hast einen Überschuss';
      color = Colors.green;
    } else if (balance < 0) {
      message = '❌ Du hast ein Defizit';
      color = Colors.red;
    } else {
      message = '⚖️ Deine Bilanz ist ausgeglichen';
      color = Colors.orange;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, _) {
          if (!transactionProvider.isLoading) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Einnahmen & Ausgaben Übersicht
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TransactionSummary(
                      label: 'Einnahmen',
                      amount: transactionProvider.transaction
                          .where((tx) => tx.amount > 0)
                          .fold(0.0, (sum, tx) => sum + tx.amount),
                      color: Colors.green,
                      icon: Icons.arrow_upward,
                    ),
                    TransactionSummary(
                      label: 'Ausgaben',
                      amount: transactionProvider.transaction
                          .where((tx) => tx.amount < 0)
                          .fold(0.0, (sum, tx) => sum + tx.amount),
                      color: Colors.red,
                      icon: Icons.arrow_downward,
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Neue Transaktion hinzufügen
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
                  onPressed: () {
                    final amount =
                        double.tryParse(widget.amountController.text) ?? 0;
                    final description = widget.descriptionController.text;

                    transactionProvider.addTransaction(amount, description);

                    // Budgetstatus nach Hinzufügen prüfen
                    final totalIncome = transactionProvider.transaction
                        .where((tx) => tx.amount > 0)
                        .fold(0.0, (sum, tx) => sum + tx.amount);

                    final totalExpense = transactionProvider.transaction
                        .where((tx) => tx.amount < 0)
                        .fold(0.0, (sum, tx) => sum + tx.amount);

                    _checkBudgetStatus(totalIncome, totalExpense);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  child: Center(child: Text('Transaktion hinzufügen')),
                ),

                SizedBox(height: 20),

                // Transaktionsliste
                Expanded(
                  child: ListView.builder(
                    itemCount: transactionProvider.transaction.length,
                    itemBuilder: (ctx, index) {
                      final tx = transactionProvider.transaction[index];
                      return ListTile(
                        title: Text(tx.description),
                        subtitle: Row(
                          children: [
                            Text(
                              '€${tx.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color:
                                    tx.amount > 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              tx.type,
                              style: TextStyle(
                                color:
                                    tx.amount > 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          tx.amount > 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: tx.amount > 0 ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

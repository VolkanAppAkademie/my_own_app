/*import 'package:flutter/material.dart';
import 'package:my_own_app/features/authentication/screens/login_page_firebase.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:my_own_app/shared/widgets/transaction_summary.dart';
import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';
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
  Future<void> _logout() async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<TransactionProvider>(
          //future: widget.transactionController.getAllTransactions(),
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
                          .fold(0, (sum, tx) => sum + tx.amount),
                      color: Colors.green,
                      icon: Icons.arrow_upward),
                  TransactionSummary(
                      label: 'Ausgaben',
                      amount: transactionProvider.transaction
                          .where((tx) => tx.amount < 0)
                          .fold(0, (sum, tx) => sum + tx.amount),
                      color: Colors.red,
                      icon: Icons.arrow_downward),
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
                  transactionProvider.addTransaction(
                      double.tryParse(widget.amountController.text) ?? 0,
                      widget.descriptionController.text);
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
      }),
    );
  }
}
*/

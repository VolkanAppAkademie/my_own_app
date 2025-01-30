import 'package:flutter/material.dart';
import 'package:my_own_app/shared/models/transaction.dart';

class BudgetHomeScreen extends StatefulWidget {
  @override
  _BudgetHomeScreenState createState() => _BudgetHomeScreenState();
}

class _BudgetHomeScreenState extends State<BudgetHomeScreen> {
  List<Transaction> transactions = [];
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _transactionType = 'Einnahme'; // Standardmäßig 'Einnahme'

  void _addTransaction() {
    final amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text;

    if (amount != null && description.isNotEmpty) {
      setState(() {
        // Je nach Auswahl wird das Vorzeichen des Betrags angepasst
        if (_transactionType == 'Ausgabe') {
          amount = -amount;
        }
        transactions.add(Transaction(amount, description, _transactionType));
      });

      _amountController.clear();
      _descriptionController.clear();
      _transactionType = 'Einnahme'; // Standard zurücksetzen
    }
  }

  double get _totalIncome {
    return transactions
        .where((tx) => tx.amount > 0)
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double get _totalExpenses {
    return transactions
        .where((tx) => tx.amount < 0)
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget App'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Einnahmen und Ausgaben anzeigen
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBudgetInfo('Einnahmen', _totalIncome, Colors.green,
                    Icons.arrow_upward),
                _buildBudgetInfo('Ausgaben', _totalExpenses, Colors.red,
                    Icons.arrow_downward),
              ],
            ),
            SizedBox(height: 20),
            // Eingabefelder für neue Transaktionen
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Betrag',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Beschreibung',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: Text('Transaktion hinzufügen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
            SizedBox(height: 20),
            // Transaktionsliste
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tx = transactions[index];
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
                        // Anzeige des Transaktionstyps
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
      ),
    );
  }

  // Funktion für die Anzeige von Einnahmen/Ausgaben
  Widget _buildBudgetInfo(
      String label, double amount, Color color, IconData icon) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              '€${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

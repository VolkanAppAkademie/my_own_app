import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/budget_provider.dart';
import 'package:my_own_app/features/add_transaction/screens/expense_screen.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';
import 'package:my_own_app/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_own_app/shared/models/transaction.dart' as my;

class IncomeScreen extends StatefulWidget {
  //final List<Transaction> transactions;

  // Wir erhalten die Transaktionen, die auf dem Hauptscreen hinzugefügt wurden
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  late FirebaseAuthRepository authRepository;

  @override
  void initState() {
    super.initState();

    authRepository =
        Provider.of<FirebaseAuthRepository>(context, listen: false);
  }

  /*void getTransactions() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('transactions').get();

    for (var doc in snapshot.docs) {
      final data = (doc.data() as Map<String, dynamic>);
      double amount =
          (data['transaction'] as Map<String, dynamic>)['amount'] ?? 0;
      String description =
          (data['transaction'] as Map<String, dynamic>)['description'] ?? '';

      widget.transactionController.addTransaction(
          doc.id, my.Transaction(amount, description, 'Einnahme'));

      print('ID: ${doc.id}, Daten: ${doc.data()}');
    }


  }
*/
  @override
  Widget build(BuildContext context) {
    // Filtern der Einnahmen
    //final incomeTransactions = transactions.where((tx) => tx.amount > 0).toList();

    return Consumer<TransactionProvider>(
        //future: widget.transactionController.getAllTransactions(),
        builder: (context, transactionProvider, _) {
      final incomeTransactions =
          //snapshot.data!.where((tx) => tx.amount > 0).toList();
          transactionProvider.transactions
              .where((tx) => tx.amount > 0)
              .toList();
      if (incomeTransactions.isEmpty) {
        return Center(child: Text('Keine Einnahmen'));
      }

      return ListView.builder(
        itemCount: incomeTransactions.length,
        itemBuilder: (ctx, index) {
          final tx = incomeTransactions[index];
          return ListTile(
            title: Text('${tx.description} (${tx.category})'),

            //Text(tx.description),
            subtitle: Text('€${tx.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green)),

            leading: Icon(
              Icons.arrow_upward,
              color: Colors.green,
            ),
          );
        },
      );
    });
  }
}

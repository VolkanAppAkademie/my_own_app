import 'package:my_own_app/shared/models/transaction.dart';

import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  Map<String, Transaction> transactionData = {
    "1": Transaction(100, "First Transaction", "Income")
  };

  @override
  void addTransaction(String id, Transaction transaction) {
    transactionData[id] = transaction;
  }

  @override
  Future<List<String>> getAllTransactionDescriptions() async {
    List<String> descriptions = [];
    for (Transaction transaction in transactionData.values) {
      descriptions.add(transaction.description);
    }

    return descriptions;
  }

  @override
  List<Transaction> getAllTransactions() {
    List<Transaction> transactions = [];
    for (Transaction transaction in transactionData.values) {
      transactions.add(transaction);
    }

    return transactions;
  }

  @override
  void removeTransaction(String id) {}
}

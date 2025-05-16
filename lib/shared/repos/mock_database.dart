import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/database_repository.dart';

class MockDatabaseRepository implements DatabaseRepository {
  Map<String, Transaction> _transactionData = {};

  @override
  Future<void> addTransaction(String id, Transaction transaction) async {
    // Füge Transaktion in die Datenbank ein
    _transactionData[id] = transaction;
  }

  @override
  Future<List<String>> getAllTransactionDescriptions() async {
    // Gibt alle Transaktionsbeschreibungen zurück
    return _transactionData.values.map((tx) => tx.description).toList();
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    // Gibt alle Transaktionen zurück
    return _transactionData.values.toList();
  }

  @override
  Future<void> removeTransaction(String id) async {
    // Entferne die Transaktion nach der ID
    _transactionData.remove(id);
  }
}

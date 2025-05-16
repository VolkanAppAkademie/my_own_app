import 'package:my_own_app/shared/models/transaction.dart';

abstract class DatabaseRepository {
  // Create
  Future<void> addTransaction(String id, Transaction transaction);

  // Read
  Future<List<String>> getAllTransactionDescriptions();
  Future<List<Transaction>> getAllTransactions();

  // Delete
  Future<void> removeTransaction(String id); // Entferne nur mit ID
}

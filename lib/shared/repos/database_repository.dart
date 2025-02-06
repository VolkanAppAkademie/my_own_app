import 'package:my_own_app/shared/models/transaction.dart';

abstract class DatabaseRepository {
  // Create
  void addTransaction(String id, Transaction transaction);
  // Read
  List<String> getAllTransactionDescriptions();
  // Delete
  void removeTransaction(String id);
}

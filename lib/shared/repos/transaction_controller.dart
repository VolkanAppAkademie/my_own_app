import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/database_repository.dart';

class TransactionController {
  final DatabaseRepository _databaseRepository;

  TransactionController(this._databaseRepository);

  void addTransaction(String id, Transaction transaction) =>
      _databaseRepository.addTransaction(id, transaction);

  Future<List<Transaction>> getAllTransactions() async {
    await Future.delayed(Duration(seconds: 3));

    return _databaseRepository.getAllTransactions();
  }
}

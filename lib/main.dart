import 'package:flutter/material.dart';
import 'package:my_own_app/app/app.dart';
import 'package:my_own_app/shared/repos/database_repository.dart';
import 'package:my_own_app/shared/repos/mock_database.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

void main() {
  DatabaseRepository databaseRepository = MockDatabase();

  final TransactionController transactionController =
      TransactionController(databaseRepository);

  runApp(MyApp(
    transactionController: transactionController,
  ));
}

//import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:flutter/widgets.dart';
import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/firestore_transaction_repo.dart';
import 'package:uuid/uuid.dart';

//import '../data/firestore_habit_repo.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [];

  bool isLoading = false;

  late final FirestoreTransactionRepo firestoreTransactionRepo;

  TransactionProvider({required this.firestoreTransactionRepo});

  Future<void> initialize() async {
    isLoading = true;

    notifyListeners();

    await Future.delayed(
        Duration(seconds: 2)); // only for testing to see loading indicator

    transactions = await firestoreTransactionRepo.getTransaction();

    isLoading = false;

    notifyListeners();
  }

  List<Transaction> getTransaction() {
    return transactions;
  }

  List<Transaction> get transaction => transactions;

  void addTransaction(double amount, String description) async {
    final id = Uuid().v4();
    String type;

    if (amount < 0) {
      type = 'Ausgabe';
    } else {
      type = 'Einnahme';
    }

    Transaction newTransaction = Transaction(
        amount: amount, description: description, type: type, id: id);
    transactions.add(newTransaction);

    await firestoreTransactionRepo.addTransaction(newTransaction);

    notifyListeners();
  }

  /*void updateHabit(String newTitle, Habit currentHabit) async {
    await firestoreHabitRepo.updateHabit(currentHabit, newTitle);

    int currentIndex = _habits.indexOf(currentHabit);

    _habits[currentIndex] = Habit(
        id: currentHabit.id, title: newTitle, isDone: currentHabit.isDone);

    notifyListeners();
  }

  void toggleHabit(Habit currentHabit) async {
    await firestoreHabitRepo.toggleHabit(currentHabit, !currentHabit.isDone);

    int currentIndex = _habits.indexOf(currentHabit);

    _habits[currentIndex] = Habit(
        id: currentHabit.id,
        title: currentHabit.title,
        isDone: !currentHabit.isDone);

    notifyListeners();
  }
  */
}

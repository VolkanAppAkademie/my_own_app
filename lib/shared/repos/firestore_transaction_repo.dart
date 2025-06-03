//import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_own_app/shared/models/transaction.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreTransactionRepo {
  final FirebaseFirestore firestore;

  final FirebaseAuth auth;

  FirestoreTransactionRepo({required this.firestore, required this.auth});

  String get _uid {
    final user = auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    return user.uid;
  }

  Future<List<model.Transaction>> getTransaction() async {
    final snapshot = await firestore
        .collection("users")
        .doc(_uid)
        .collection("transactions")
        .get();
    return snapshot.docs
        .map((doc) => model.Transaction.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addTransaction(model.Transaction transaction) async {
    await firestore
        .collection("users")
        .doc(_uid)
        .collection("transactions")
        .doc(transaction.id)
        .set(transaction.toMap());
  }

  /*Future<void> updateHabit(Habit habit, String newTitle) async {
    await firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .doc(habit.id)
        .update({'title': newTitle});
  }

  Future<void> toggleHabit(Habit habit, bool isDone) async {
    await firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .doc(habit.id)
        .update({'isDone': isDone});
  }
  */
}

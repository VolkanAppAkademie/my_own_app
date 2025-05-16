/*import 'dart:convert';

import 'package:my_own_app/shared/models/transaction.dart';
import 'package:my_own_app/shared/repos/mock_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements MockDatabaseRepository {
  //Map<String, Transaction> _transactionData = {}; //wird nicht mehr gebraucht

  @override
  Future<void> addTransaction(String id, Transaction transaction) async {
    // gibt uns die Instanz der SharedPreferences (lokaler Speicher)
    //worauf wir dann mit get und set zugreifen
    final prefs = await SharedPreferences.getInstance();

    //prefs.setDouble('$id:amount', transaction.amount);
    print(transaction.amount);
    // Füge Transaktion in die Datenbank ein

//transaction wird in einen Json (String) umgwandelt
//mit der Funktion eine transaction machen (tojson)
    String Json = jsonEncode(transaction);
//Key und value werden in den SharedPfefs gespeichert als String
    prefs.setString(id, Json);
  }

  @override
  Future<List<String>> getAllTransactionDescriptions() async {
    final Sekretaerin = await SharedPreferences.getInstance();
    Sekretaerin.getStringList("transaction").map((tx) => tx.description)

    // Gibt alle Transaktionsbeschreibungen zurück
    return transactionData.values.map((tx) => tx.description).toList();
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
*/

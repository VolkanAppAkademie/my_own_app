import 'package:flutter/foundation.dart';

class Transaction {
  double amount;
  String description;
  String category;
  String type;
  String id;

  Transaction({
    required this.amount,
    required this.description,
    required this.category,
    required this.type,
    required this.id,
  });

  //get transactions => null;

  Transaction.fromMap(Map<String, dynamic> json, String id)
      : amount = json['amount'] as double,
        description = json['description'] as String,
        category = json['category'] as String,
        type = json['type'] as String,
        id = json['id'];

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'description': description,
        'category': category,
        'type': type,
        'id': id
      };
}

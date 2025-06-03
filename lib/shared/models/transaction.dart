class Transaction {
  double amount;
  String description;
  String type;
  String id;

  Transaction({
    required this.amount,
    required this.description,
    required this.type,
    required this.id,
  });

  get transactions => null;

  Transaction.fromMap(Map<String, dynamic> json, String id)
      : amount = json['amount'] as double,
        description = json['description'] as String,
        type = json['type'] as String,
        id = json['id'];

  Map<String, dynamic> toMap() =>
      {'amount': amount, 'description': description, 'type': type, 'id': id};
}

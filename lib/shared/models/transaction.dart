class Transaction {
  double amount;
  String description;
  String type;

  Transaction(this.amount, this.description, this.type);

  get transactions => null;

  get id => null;

  Transaction.fromJson(Map<String, dynamic> json)
      : amount = json['amount'] as double,
        description = json['description'] as String,
        type = json['type'] as String;

  Map<String, dynamic> toJson() =>
      {'amount': amount, 'description': description, 'type': type};
}

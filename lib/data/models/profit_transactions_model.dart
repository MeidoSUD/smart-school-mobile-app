class ProfitTransactionsModel {
  final int id;
  final String type;
  final double amount;
  final String date;
  final String description;

  ProfitTransactionsModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory ProfitTransactionsModel.fromJson(Map<String, dynamic> json) {
    return ProfitTransactionsModel(
      id: json['id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date,
      'description': description,
    };
  }

  ProfitTransactionsModel copyWith({
    int? id,
    String? type,
    double? amount,
    String? date,
    String? description,
  }) {
    return ProfitTransactionsModel(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }
}

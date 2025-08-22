class Order {
  final int id;
  final String establishment;
  final double amount;
  final DateTime date;
  final String category;
  final String userId; // owner of this order

  Order({required this.id, required this.establishment, required this.amount, required this.date, required this.category, required this.userId});

  Order copyWith({int? id, String? establishment, double? amount, DateTime? date, String? category, String? userId}) {
    return Order(
      id: id ?? this.id,
      establishment: establishment ?? this.establishment,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      userId: userId ?? this.userId,
    );
  }
}

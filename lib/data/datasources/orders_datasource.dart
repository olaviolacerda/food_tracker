import '../../models/order.dart';

abstract class OrdersDataSource {
  /// Fetch orders optionally filtered by userId. Returns most-recent-first.
  List<Order> fetchOrders({String? userId});
  void insertOrder(Order order);
}

class InMemoryOrdersDataSource implements OrdersDataSource {
  final List<Order> _store = [
    Order(id: 1, establishment: "McDonald's", amount: 25.9, date: DateTime(2025, 1, 15), category: 'Delivery', userId: 'alice'),
    Order(id: 2, establishment: "Pizza Hut", amount: 45.5, date: DateTime(2025, 1, 14), category: 'Delivery', userId: 'bob'),
    Order(id: 3, establishment: "Restaurante Italiano", amount: 89.0, date: DateTime(2025, 8, 12), category: 'Restaurante', userId: 'alice'),
  ];

  @override
  List<Order> fetchOrders({String? userId}) {
    final filtered = (userId == null) ? _store : _store.where((o) => o.userId == userId).toList();
    return List.unmodifiable(filtered.reversed);
  }

  @override
  void insertOrder(Order order) {
    _store.add(order);
  }
}

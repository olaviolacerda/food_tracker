import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  return OrdersNotifier();
});

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier()
      : super([
          Order(id: 1, establishment: "McDonald's", amount: 25.9, date: DateTime(2024, 1, 15), category: 'Delivery'),
          Order(id: 2, establishment: "Pizza Hut", amount: 45.5, date: DateTime(2024, 1, 14), category: 'Delivery'),
          Order(id: 3, establishment: "Restaurante Italiano", amount: 89.0, date: DateTime(2024, 1, 12), category: 'Restaurante'),
        ]);

  void addOrder(Order order) {
    state = [order, ...state];
  }
}

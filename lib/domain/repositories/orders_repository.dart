import '../../models/order.dart';

abstract class OrdersRepository {
  /// Returns all orders (most-recent first).
  List<Order> getOrders();

  /// Adds an order to the repository.
  void addOrder(Order order);
}

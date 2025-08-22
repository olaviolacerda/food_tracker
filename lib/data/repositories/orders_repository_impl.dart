import '../../models/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_datasource.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersDataSource dataSource;

  OrdersRepositoryImpl(this.dataSource);

  @override
  List<Order> getOrders() => dataSource.fetchOrders();

  List<Order> getOrdersForUser(String userId) => dataSource.fetchOrders(userId: userId);

  @override
  void addOrder(Order order) => dataSource.insertOrder(order);
}

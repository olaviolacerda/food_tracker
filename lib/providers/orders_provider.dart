import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../data/datasources/orders_datasource.dart';
import '../data/repositories/orders_repository_impl.dart';
import '../domain/usecases/get_orders_usecase.dart';
import '../domain/usecases/add_order_usecase.dart';
import '../data/datasources/auth_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';

final authProvider = Provider<String?>((ref) {
  final ds = InMemoryAuthDataSource();
  final repo = AuthRepositoryImpl(ds);
  return repo.getCurrentUserId();
});

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  // Wire up in-memory datasource + repository + usecases.
  final dataSource = InMemoryOrdersDataSource();
  final repository = OrdersRepositoryImpl(dataSource);
  final getOrders = GetOrdersUseCase(repository);
  final addOrder = AddOrderUseCase(repository);
  final currentUserId = ref.read(authProvider);
  return OrdersNotifier(getOrders, addOrder, repository: repository, currentUserId: currentUserId);
});

class OrdersNotifier extends StateNotifier<List<Order>> {
  final GetOrdersUseCase _getOrders;
  final AddOrderUseCase _addOrder;
  final OrdersRepositoryImpl? repository;
  final String? currentUserId;

  OrdersNotifier(this._getOrders, this._addOrder, {this.repository, this.currentUserId}) : super([]) {
    // initialize state from repository (user-scoped if available)
    _refresh();
  }

  void _refresh() {
    if (repository != null && currentUserId != null) {
      state = repository!.getOrdersForUser(currentUserId!);
    } else {
      state = _getOrders();
    }
  }

  void addOrder(Order order) {
    _addOrder(order);
    _refresh();
  }
}

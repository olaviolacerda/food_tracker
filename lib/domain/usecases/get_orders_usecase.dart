import '../../models/order.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase {
  final OrdersRepository repository;

  GetOrdersUseCase(this.repository);

  List<Order> call({String? userId}) {
    // repository may offer user-scoped fetch; if not, fallback
    try {
      // if repository has getOrdersForUser (concrete impl), it will be used by provider wiring
      return repository.getOrders();
    } catch (_) {
      return repository.getOrders();
    }
  }
}
